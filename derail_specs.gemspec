# frozen_string_literal: true

require_relative "lib/derail_specs/version"

Gem::Specification.new do |spec|
  spec.name          = "derail_specs"
  spec.version       = DerailSpecs::VERSION
  spec.authors       = ["Alex Piechowski"]
  spec.email         = ["alex@piechowski.io"]

  spec.summary       = "Rails test server for external tests."
  # spec.description   = ""
  spec.homepage      = "https://github.com/roshreview/derail_specs"
  spec.license       = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/roshreview/derail_specs"
  spec.metadata["changelog_uri"] = "https://github.com/roshreview/derail_specs/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "puma", ">= 3.8.0"
  spec.add_dependency "railties", ">= 5.2.0"
end
