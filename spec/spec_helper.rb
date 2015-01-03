require 'bundler/setup'
Bundler.setup

require 'serialize_has_many'
require 'active_support/all'
require 'active_model'

class TestParentModel
  include ActiveModel::Model
  attr_accessor :children
end

class TestChildModel
  include ActiveModel::Model
  attr_accessor :name

  def attributes
    { name: name }
  end
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
end
