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
  config.command = './tests.sh' # <-- your test command here, or blank for infinite mode
  config.host = '127.0.0.1'
  config.port = 3001
end
```

Alternatively, if you don't set a `config.command`, the server will boot in
*infinite* mode and will not stop until receiving an INT signal (IE Ctrl+c).
This is good for when your test command isn't available in a rails context,
like when you are running rails in docker, but have a test application running
on the host machine.

## Usage

To run tests, run

    $ rails derail_specs:run

### Reset Transaction

Inside your preferred test suite, configure a before_each that runs a get request
to `HOST:PORT/reset-transaction`.

This runs a rollback and begins a new transaction.

For instance, with curl and the default config, transactions can be reset with:

    $ curl 127.0.0.1:3001/reset-transaction

Or if you're using [detox](https://github.com/wix/Detox):

```javascript
beforeEach(async () => {
    await fetch('127.0.0.1:3001/reset-transaction');
  });
```

### FactoryBot.create

Post with a JSON array to `/factory-bot/create` with the following structure:

```JSON
["test", { "name": "Test Name", "created_at": "2011-11-11 11:11:11" }]
````

which will run:

```ruby
FactoryBot.create(:test, name: "Test Name", created_at: "2011-11-11 11:11:11")
```

Example curl:

```bash
curl -X POST \
      -d '["test", { "name": "Test Name from Curl", "created_at": "2011-11-11 11:11:11" }]' \
      -H 'Content-Type: application/json' \
      127.0.0.1:3001/factory-bot/create
```

### Initializer Hooks

By default, DerailSpecs doesn't run any fixtures. You can configure global fixture
loading with initializer hooks in `config/initializers/derail_specs.rb`:

```ruby
return unless Rails.env.test?

DerailSpecs.hooks.before_server_start do
  # Add our fixtures before the resettable transaction is started
  fixtures_dir = Rails.root.join("spec/fixtures")
  fixture_files = Dir.glob(fixtures_dir.join("**/*.yml")).map do |f|
    f[(fixtures_dir.to_s.size + 1)..-5]
  end

  @fixtures = ActiveRecord::FixtureSet.create_fixtures(
    fixtures_dir,
    fixture_files,
  )
end

DerailSpecs.hooks.before_server_stop do
  @fixtures.map(&:model_class).each(&:delete_all)
end
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/roshreview/derail_specs. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/roshreview/derail_specs/blob/master/CODE_OF_CONDUCT.md).

Big thanks to [testdouble/cypress-rails](https://github.com/testdouble/cypress-rails)
to the puma server + transactions work they did for the cypress environment.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the DerailSpecs project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/roshreview/derail_specs/blob/master/CODE_OF_CONDUCT.md).
