# Scot
[![Build Status](https://img.shields.io/travis/nomadium/scot.svg)][travis]
[![Dependency Status](https://img.shields.io/gemnasium/nomadium/scot.svg)][gemnasium]
[![Code Climate](https://img.shields.io/codeclimate/github/nomadium/scot.svg)][codeclimate]
[![Coverage Status](http://img.shields.io/coveralls/nomadium/scot.svg)][coveralls]

[travis]: https://travis-ci.org/nomadium/scot
[gemnasium]: https://gemnasium.com/nomadium/scot
[codeclimate]: https://codeclimate.com/github/nomadium/scot
[coveralls]: https://coveralls.io/r/nomadium/scot

yet another git implementation in ruby

git is defined by his creator as a "stupid content tracker", hence this gem is named scot, just that.

Warning: this is alpha code, so I'll not be responsible for any data loss caused by this tool on your git repos.
You have been warned and the MIT license is very clear anyway about no warranties whatsoever provided by using
code licensed under it.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'scot'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install scot

## Usage

You can use scot via command line interface or you can import it in your project just by requiring the scot module.

```ruby
require "scot"
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/nomadium/scot. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

