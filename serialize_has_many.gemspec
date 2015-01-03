# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'serialize_has_many/version'

Gem::Specification.new do |spec|
  spec.name          = "serialize_has_many"
  spec.version       = SerializeHasMany::VERSION
  spec.authors       = ["Subhas"]
  spec.summary       = %q{Serialize has_many relationships into a single column}
  spec.description   = %q{Serialize has_many relationships into a single column}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = Dir['README.md', 'lib/**/*']
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.1.0"
end
