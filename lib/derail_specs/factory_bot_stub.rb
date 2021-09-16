module DerailSpecs
  class FactoryBot
    def self.create(*_)
      puts "factory_bot_rails is not installed in group :test"
      puts "Please add factory_bot_rails to your Gemfile to use this feature"
    end
  end
end
