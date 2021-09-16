# DerailSpecs

DerailSpecs is a simple gem that makes it easy to write integration specs outside
of the rails environment (derailed).

DerailsSpecs boots puma and provides a GET route (`/reset-transaction`) in which
rollbacks your transaction and begins a new transaction for the next test.
At the end of the test suite, it rollbacks the final transaction.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'derail_specs'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install derail_specs

To install the initializer, run:

    $ rails g derail_specs:install

Then modify the configuration file located at config/initializers/derail_specs.rb
to include your test command:

```ruby
DerailSpecs.configure do |config|
  config.command = './tests.sh' # <-- your test command here
  config.host = '127.0.0.1'
  config.port = 3001
end
```

## Usage

To run tests, run

    $ rails derail_specs:run

Inside your preferred test suite, configure a before_each that runs a get request
to `HOST:PORT/reset-transaction`.

For instance, with curl and the default config, transactions can be reset with:

    $ curl 127.0.0.1:3001/reset-transaction

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/roshreview/derail_specs. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/roshreview/derail_specs/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the DerailSpecs project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/roshreview/derail_specs/blob/master/CODE_OF_CONDUCT.md).
