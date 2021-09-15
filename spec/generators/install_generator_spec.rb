require 'spec_helper'
require "generators/derail_specs/install_generator"
require "generator_spec"

RSpec.describe DerailSpecs::Generators::InstallGenerator, type: :generator do
  destination File.expand_path("../../tmp", __dir__)

  before do
    prepare_destination
    run_generator
  end

  it do
    assert_file 'config/initializers/derail_specs.rb'
  end
end
