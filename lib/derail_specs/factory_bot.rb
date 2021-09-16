begin
  gem 'factory_bot_rails'
  require 'factory_bot_rails'

  module DerailSpecs
    class FactoryBot
      def self.create(factory, options = nil)
        ::FactoryBot.create(factory, options)
      end
    end
  end
rescue Gem::LoadError
  require_relative 'factory_bot_stub'
end
