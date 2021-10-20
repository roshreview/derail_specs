begin
  gem 'factory_bot_rails'
  require 'factory_bot_rails'

  module DerailSpecs
    class FactoryBot
      def self.create(*args)
        ::FactoryBot.create(*args)
      end

      def self.create_list(*args)
        puts args.to_json
        ::FactoryBot.create_list(*args)
      end
    end
  end
rescue Gem::LoadError
  require_relative 'factory_bot_stub'
end
