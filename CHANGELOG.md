## [Unreleased]

## [0.6.0] - 2021-09-23

- Add /factory-bot/create-list to map to FactoryBot.create_list

## [0.5.1] - 2021-09-23

- Fixed a bug with Ruby 2.6 and Rails >= 6 where #bind_call (Ruby 2.7) was used instead of #bind#call

## [0.5.0] - 2021-09-17

- Add before_server_start and before_server_stop initializer hooks

## [0.4.0] - 2021-09-16

- Add infinite server mode, which can be used by not setting a command in the config

## [0.3.0] - 2021-09-16

- Add `/factory-bot/create` route to map to FactoryBot.create
- Run `rake derail_specs:run` in Rails test environment

## [0.2.1] - 2021-09-15

- Fix Rails 5.2 missing method `ActiveRecord::TestFixtures.setup_shared_connection_pool`

## [0.2.0] - 2021-09-15

- Initial release
