## OSS Contributions

List popular open source contributions from any github user.

* Looks at user's repositories
* Checks forks for actual commits by user
* Lists most popular sources and forks (by stars)
* Each repo is listed by name, stars, url (direct link to commits by user)

### Usage

```ruby
require "oss-contributions"

oss = OSS::Contributions.new

jisaacks = oss.list("jisaacks")

puts jisaacks.published   # most popular repos jisaacks has authored
puts jisaacks.contributed # most popular repos jisaacks has contributed to

# can be used to generate links to contributions by user
puts jisaacks.contributed.first.commits # https://github.com/mbostock/d3/commits?author=jisaacks

# can also specify an access_token to prevent rate limit:
oss = OSS::Contributions.new access_token:"my-secret-access-token"
```

### Installation

```
$ gem install oss-contributions
```

### License

MIT