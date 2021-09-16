# frozen_string_literal: true

require 'spec_helper'

RSpec.describe DerailSpecs do
  describe '.configure' do
    it 'allows for block that sets configuration values' do
      DerailSpecs.configure do |config|
        config.command = 'bin/spongebob'
      end

      expect(DerailSpecs.configuration.command).to eq 'bin/spongebob'
    end
  end
end
