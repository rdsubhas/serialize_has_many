# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'serialize_has_many/version'

Gem::Specification.new do |spec|
  spec.name          = "serialize_has_many"
  spec.version       = SerializeHasMany::VERSION
  spec.authors       = ["Subhas"]
  spec.summary       = %q{Serialize has_many relationships into a single column. Easy NoSQL with ActiveRecord!}
  spec.description   = %q{Serializes `has_many` relationships into a single column while still doing attributes, validations, callbacks, nested forms and fields_for. Easy NoSQL with ActiveRecord!}
  spec.homepage      = "https://github.com/rdsubhas/serialize_has_many"
  spec.license       = "MIT"

  spec.files         = Dir['README.md', 'lib/**/*']
  spec.require_paths = ["lib"]

  spec.add_dependency "activesupport", ">= 4.0.0"
  spec.add_dependency "activemodel", ">= 4.0.0"

  spec.add_development_dependency "bundler", ">= 1.0.0"
  spec.add_development_dependency "rake", ">= 0.9.0"
  spec.add_development_dependency "rspec", "~> 3.1.0"
  spec.add_development_dependency "coveralls"
end
