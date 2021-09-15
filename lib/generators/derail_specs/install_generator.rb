require 'rails/generators'

module DerailSpecs
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../templates", __dir__)

      def copy_config
        copy_file(
          "config/initializers/derail_specs.rb",
          "config/initializers/derail_specs.rb",
        )
      end
    end
  end
end
