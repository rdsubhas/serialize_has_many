require 'spec_helper'
require 'json'
require 'yaml'

describe SerializeHasMany::Serializer do

  describe '#new' do
    it 'should require :using' do
      expect {
        described_class.new(AttrStruct)
      }.to raise_error(/does not respond to/)
    end

    it ':using should respond to :load' do
      expect {
        described_class.new(AttrStruct, using: double())
      }.to raise_error(/does not respond to load/)
    end

    it ':using should respond to :dump' do
      expect {
        described_class.new(AttrStruct, using: double(load: nil))
      }.to raise_error(/does not respond to dump/)
    end

    it ':using JSON' do
      expect { described_class.new(AttrStruct, using: JSON) }.to_not raise_error
    end

    it ':using YAML' do
      expect { described_class.new(AttrStruct, using: YAML) }.to_not raise_error
    end
  end

  describe '#load' do
    describe 'nil' do
      subject { described_class.new(AttrStruct, using: JSON).load(nil) }
      it { should be_empty }
      it { should be_kind_of SerializeHasMany::Collection }
    end

    describe 'empty string' do
      subject { described_class.new(AttrStruct, using: JSON).load('') }
      it { should be_empty }
      it { should be_kind_of SerializeHasMany::Collection }
    end

    describe 'empty object' do
      subject { described_class.new(AttrStruct, using: JSON).load('{}') }
      it { should be_empty }
      it { should be_kind_of SerializeHasMany::Collection }
    end

    describe 'error' do
      it {
        expect {
          described_class.new(AttrStruct, using: JSON).load('#BLAH#')
        }.to raise_error
      }
    end

    describe 'object' do
      subject { described_class.new(AttrStruct, using: JSON).load([{a: 'A'}].to_json) }
      it { should_not be_empty }
      it { expect(subject[0]).to be_kind_of AttrStruct }
      it { expect(subject[0].a).to eq 'A' }
    end
  end

end
