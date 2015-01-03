require 'rails_helper'

describe SerializeHasMany::Serializer do

  describe 'new' do
    it 'should require :using' do
      expect {
        described_class.new(nil)
      }.to raise_error(/does not respond to/)
    end

    it ':using should respond to :load' do
      expect {
        described_class.new(nil, using: double())
      }.to raise_error(/does not respond to load/)
    end

    it ':using should respond to :dump' do
      expect {
        described_class.new(nil, using: double(load: nil))
      }.to raise_error(/does not respond to dump/)
    end

    it ':using JSON' do
      described_class.new(nil, using: JSON)
    end

    it ':using YAML' do
      described_class.new(nil, using: YAML)
    end
  end

end
