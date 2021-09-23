module DerailSpecs
  class FactoryBot
    def self.create(*_)
      not_installed_message
    end

    def self.create_list(*_)
      not_installed_message
    end

    def self.not_installed_message
      puts "factory_bot_rails is not installed in group :test"
      puts "Please add factory_bot_rails to your Gemfile to use this feature"
    end
  end
end
