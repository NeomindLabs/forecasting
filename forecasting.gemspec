
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "forecasting/version"

Gem::Specification.new do |spec|
  spec.name          = "forecasting"
  spec.version       = Forecasting::VERSION
  spec.authors       = ["Jordan Owens"]
  spec.email         = ["jordan@neomindlabs.com"]

  spec.summary       = %q{Ruby wrapper for the Forecast API}
  spec.description   = %q{Interact with the Forecast API from your Ruby application}
  spec.homepage      = "https://github.com/NeomindLabs/forecasting"
  spec.license       = "MIT"
  spec.required_ruby_version = ">= 2.6"

  spec.files = %w'README.md LICENSE CHANGELOG.md' +  Dir['lib/**/*.rb']
  spec.require_paths = ["lib"]

  spec.add_dependency "http"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 3.0"
end