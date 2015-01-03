require 'spec_helper'
require 'json'
require 'yaml'

describe SerializeHasMany::Serializer do

  describe '#new' do
    it 'using should respond to :load' do
      expect {
        described_class.new(AttrStruct, double(dump: nil))
      }.to raise_error(/does not implement load/)
    end

    it 'using should respond to :dump' do
      expect {
        described_class.new(AttrStruct, double(load: nil))
      }.to raise_error(/does not implement dump/)
    end

    it 'using JSON' do
      expect { described_class.new(AttrStruct, JSON) }.to_not raise_error
    end

    it 'using YAML' do
      expect { described_class.new(AttrStruct, YAML) }.to_not raise_error
    end
  end

  describe '#load' do
    describe 'nil' do
      subject { described_class.new(AttrStruct, JSON).load(nil) }
      it { should be_empty }
      it { should be_kind_of SerializeHasMany::Collection }
    end

    describe 'empty string' do
      subject { described_class.new(AttrStruct, JSON).load('') }
      it { should be_empty }
      it { should be_kind_of SerializeHasMany::Collection }
    end

    describe 'empty object' do
      subject { described_class.new(AttrStruct, JSON).load('{}') }
      it { should be_empty }
      it { should be_kind_of SerializeHasMany::Collection }
    end

    describe 'error' do
      it {
        expect {
          described_class.new(AttrStruct, JSON).load('#BLAH#')
        }.to raise_error
      }
    end

    describe 'object' do
      subject { described_class.new(AttrStruct, JSON).load([{a: 'A'}].to_json) }
      it { should_not be_empty }
      it { expect(subject[0]).to be_kind_of AttrStruct }
      it { expect(subject[0].a).to eq 'A' }
    end
  end

  describe '#dump' do
    subject { described_class.new(AttrStruct, JSON) }

    it 'should dump collection object' do
      attrs = [{ a: 1, b: 2, c: 3 }]
      r = SerializeHasMany::Collection.new(AttrStruct, attrs)
      expect(subject.dump(r)).to eq attrs.to_json
    end

    it 'should dump nil' do
      expect(subject.dump(nil)).to be_nil
    end

    it 'should not accept other attributes' do
      expect { subject.dump([1, 2]) }.to raise_error(/does not have correct type/)
    end
  end

end
