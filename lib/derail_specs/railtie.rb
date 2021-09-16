module DerailSpecs
  require 'rails'

  class Railtie < Rails::Railtie
    rake_tasks { load 'tasks/derail_specs.rake' }
  end
end
