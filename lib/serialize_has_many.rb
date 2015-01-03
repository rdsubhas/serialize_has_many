require "serialize_has_many/version"

module SerializeHasMany
  autoload :Concern,    'serialize_has_many/concern'
  autoload :Serializer, 'serialize_has_many/serializer'
  autoload :Validators, 'serialize_has_many/validators'
end
