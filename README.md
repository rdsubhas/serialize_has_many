# SerializeHasMany

[![Build Status](https://travis-ci.org/rdsubhas/serialize_has_many.svg?branch=master)](https://travis-ci.org/rdsubhas/serialize_has_many) [![Code Climate](https://codeclimate.com/github/rdsubhas/serialize_has_many/badges/gpa.svg)](https://codeclimate.com/github/rdsubhas/serialize_has_many) [![Coverage Status](https://img.shields.io/coveralls/rdsubhas/serialize_has_many.svg)](https://coveralls.io/r/rdsubhas/serialize_has_many)

Serializes `has_many` relationships into a single column while still doing attributes, validations, callbacks, nested forms and fields_for. Easy NoSQL with ActiveRecord!

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'serialize_has_many'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install serialize_has_many

## Usage

Assume you have a Parent has-many Child relation. To use `serialize_has_many`:

* Child should respond to `attributes` and `new(attributes)`. To be clear:
  * `child.attributes` should give a hash
  * `Child.new(attributes)` should take that hash
* Parent should have an attribute to store the serialized data, preferably `text` datatype
* Add `serialize_has_many` in the Parent

### Example

(For a real scenario, check `example/app/models/`)

```ruby
# Make Child to use ActiveModel::Model instead of ActiveRecord
class Child
  include ActiveModel::Model
  attr_accessor :name, :age, ...
  validates ...

  def attributes
    { name: name, age: age, ... }
  end
end

# Convert Parent to use serialize_has_many instead of has_many
class Parent < ActiveRecord::Base
  include SerializeHasMany::Concern
  serialize_has_many /* name of column */, /* Child class */,
    using: /* JSON|YAML */,
    validate: /* set true to validate child models when validating parent */,
    reject_if: /* proc to reject empty children when submitting from nested forms */
end
```

### Works With

* Tested on Rails 4.0 and above, Ruby 1.9.3+
* For the Child model, you can use any class that you want, as long as `attributes` provides a hash, and `new(attributes)` takes that hash. Some options are:
  * ActiveModel
  * Virtus
  * ActiveAttr

## Contributing

1. Fork it ( https://github.com/[my-github-username]/serialize_has_many/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
