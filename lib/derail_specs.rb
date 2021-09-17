# frozen_string_literal: true

require_relative "derail_specs/version"

module DerailSpecs
  class Error < StandardError; end

  def self.configuration
    @configuration ||= Struct
                       .new(
                         :command,
                         :host,
                         :port,
                         keyword_init: true,
                       )
                       .new(
                         host: '127.0.0.1',
                         port: 3001,
                       )
  end

  def self.configure
    yield(configuration)
  end
end

require 'derail_specs/boot'
require 'derail_specs/transaction'
require 'derail_specs/railtie'
require 'derail_specs/factory_bot'
require 'derail_specs/initializer_hooks'
