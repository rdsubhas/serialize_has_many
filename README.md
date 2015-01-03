# SerializeHasMany

Serializes `has_many` relationships into a single column while still doing attributes, validations, callbacks, nested forms and fields_for. Easy NoSQL with ActiveRecord.

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

* Child should respond to `attributes` and `new(attributes)`
* Parent should have a `text` column attribute to store the serialized data
* Add `serialize_has_many` in the Parent

### Example

(For a real scenario, check `example/app/models/`)

    ```ruby
    class Child
      include ActiveModel::Model
      attr_accessor :name, :age, ...
      validates ...

      def attributes
        { name: name, age: age, ... }
      end
    end


    class Parent < ActiveRecord::Base
      include SerializeHasMany::Concern
      serialize_has_many :<name-of-column>, Child, using: <JSON|YAML>, validate: <true|false>
    end
    ```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/serialize_has_many/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
