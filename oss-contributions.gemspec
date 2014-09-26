Gem::Specification.new do |s|
  s.name        = "oss-contributions"
  s.version     = "0.0.1"
  s.date        = Time.now.strftime("%Y-%m-%d")
  s.summary     = "List your most popular github contributions"
  s.description = "List your most popular github contributions, looks at your forks and checks if you have actually contributed to them."
  s.authors     = ["JD Isaacks"]
  s.email       = "jd@jisaacks.com"
  s.files       = ["lib/oss-contributions.rb"]
  s.homepage    = "http://rubygems.org/jsaacks/oss-contributions"
  s.license     = "MIT"

  s.add_dependency("faraday", "~> 0.9")
  s.add_dependency("hashie", "~> 3.1")
end
