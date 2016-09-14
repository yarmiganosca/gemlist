# Gemlist

I built `gemlist` because I wanted a programmatic way to do what [dundler](http://github.com/samphippen/dundler) does:
1. figure out what gems would be installed by a given project
2. give each one a separate `RUN gem install $name -v $version` line in a Dockerfile

I want this capability because a containerization tool I work on builds Docker images from template-generated Dockerfiles, and it'd be nice to not have to wait for `nokogiri` to re-install every time we need to re-containerize a Rails application (as an example).

Given this, I have a very specific set of assumptions:
1. I don't care about local (`path => ...`) dependencies.
2. I don't care about git (`git => ...`) dependencies.
3. I do care about being able to include or exclude bundle groups.
4. I don't actually want to install gems, just get a list of them.
5. I have local filesystem access to the Gemfile and Gemfile.lock of the target project.

If these assumptions line up with a problem you're trying to solve, then I hope this saves you time and energy! And, if it does, feel free to contact me, because I'd be interested in hearing about the container or container-adjacent things you're doing with this.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'gemlist'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install gemlist

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/yarmiganosca/gemlist. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

