require "faraday"
require "hashie"
require "json"
require "pry"

class Contributions
  def conn
    @conn ||= Faraday.new 'https://api.github.com'
  end

  def api(path)
    obj = JSON.parse conn.get(path).body
    if obj.is_a?(Hash)
      h = Hashie::Mash.new obj
      if h.message && h.message =~ /API rate limit exceeded/
        raise "API rate limit exceeded"
      elsif h.message
        raise h.message
      end
      h
    elsif obj.is_a?(Array)
      obj.map { |o| Hashie::Mash.new(o) }
    else
      obj
    end
  end

  def repos(user)
    api "/users/#{user}/repos"
  end

  def repo(owner, repo)
    api "/repos/#{owner}/#{repo}"
  end

  def is_contributor?(user,owner,repo)
    api("/repos/#{owner}/#{repo}/contributors").any? do |contributor|
      contributor.login == user
    end
  end

  def list(user)
    the_list = repos(user).reduce(published: [], contributed: []) do |l, r|
      repo_ok = true
      repo_ok = false if r.private
      type = r.fork ? :contributed : :published
      if r.fork
        r = repo(user, r.name).source
        repo_ok = false unless is_contributor?(user, r.owner.login, r.name)
      end
      if repo_ok
        l[type] << Hashie::Mash.new({
          name: r.name,
          stars: r.stargazers_count,
          commits: "#{r.html_url}/commits?author=#{user}"
        })
      end
      l
    end
    the_list[ :published   ] = the_list[ :published   ].sort_by(&:stars).reverse
    the_list[ :contributed ] = the_list[ :contributed ].sort_by(&:stars).reverse
    Hashie::Mash.new(the_list)
  end
end
