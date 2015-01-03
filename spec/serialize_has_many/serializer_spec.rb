require 'spec_helper'
require 'json'
require 'yaml'

describe SerializeHasMany::Serializer do

  describe '#new' do
    it 'using should respond to :load' do
      expect {
        described_class.new(OpenStruct, double(dump: nil))
      }.to raise_error(/does not implement load/)
    end

    it 'using should respond to :dump' do
      expect {
        described_class.new(OpenStruct, double(load: nil))
      }.to raise_error(/does not implement dump/)
    end

    it 'using JSON' do
      expect { described_class.new(OpenStruct, JSON) }.to_not raise_error
    end

    it 'using YAML' do
      expect { described_class.new(OpenStruct, YAML) }.to_not raise_error
    end
  end

  describe '#load' do
    subject { described_class.new(OpenStruct, JSON) }

    it 'nil as empty array' do
      expect(subject.load(nil)).to be_empty
    end

    it 'empty string as empty array' do
      expect(subject.load('')).to be_empty
    end

    it 'items as model classes' do
      json = [{ a: 1 }, { b: 2 }].to_json
      arr  = subject.load(json)
      expect(arr.size).to eq 2
      expect(arr[0]).to eq OpenStruct.new({ a: 1 })
      expect(arr[1]).to eq OpenStruct.new({ b: 2 })
    end

    it 'nulls as nils' do
      json = [nil, nil].to_json
      arr  = subject.load(json)
      expect(arr.size).to eq 2
      expect(arr[0]).to be_nil
      expect(arr[1]).to be_nil
    end

    it 'string as error' do
      expect { subject.load('foo'.to_json) }.to raise_error(/not an array or nil/)
    end

    it 'primitive as error' do
      expect { subject.load(1.to_json) }.to raise_error(/not an array or nil/)
    end

    it 'hash as error' do
      expect { subject.load({}.to_json) }.to raise_error(/not an array or nil/)
    end
  end

  describe '#dump' do
    subject { described_class.new(OpenStruct, JSON) }

    it 'array as array' do
      attrs = [{ a: 1, b: 2, c: 3 }]
      expect(subject.dump(attrs)).to eq attrs.to_json
    end

    it 'empty array as empty array' do
      expect(subject.dump([])).to eq [].to_json
    end

    it 'nil as nil' do
      expect(subject.dump(nil)).to be_nil
    end

    it 'string as error' do
      expect { subject.dump('foo') }.to raise_error(/not an array or nil/)
    end

    it 'primitive as error' do
      expect { subject.dump(1) }.to raise_error(/not an array or nil/)
    end

    it 'hash as error' do
      expect { subject.dump({}) }.to raise_error(/not an array or nil/)
    end
  end

end
