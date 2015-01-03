require "serialize_has_many/version"

module SerializeHasMany
  autoload :Concern,    'serialize_has_many/concern'
  autoload :Serializer, 'serialize_has_many/serializer'
  autoload :Collection,   'serialize_has_many/collection'
end
