# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'volabit/version'

Gem::Specification.new do |spec|
  spec.name          = "volabit"
  spec.version       = Volabit::VERSION
  spec.authors       = ["Volabit Team"]
  spec.email         = ["hola@volabit.com"]
  spec.summary       = %q{Library for the Volabit API.}
  spec.description   = %q{Integrate the Volabit services in your app with ease.}
  spec.homepage      = "https://github.com/coincovemx/api-client"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "oauth2", "~> 1.0"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.2"
  spec.add_development_dependency "pry-byebug", "~> 3.0"
end
