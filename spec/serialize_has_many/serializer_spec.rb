require 'spec_helper'
require 'json'
require 'yaml'

describe SerializeHasMany::Serializer do

  describe '#new' do
    it 'using should respond to :load' do
      expect {
        described_class.new(TestChildModel, double(dump: nil))
      }.to raise_error(/does not implement load/)
    end

    it 'using should respond to :dump' do
      expect {
        described_class.new(TestChildModel, double(load: nil))
      }.to raise_error(/does not implement dump/)
    end

    it 'using JSON' do
      expect { described_class.new(TestChildModel, JSON) }.to_not raise_error
    end

    it 'using YAML' do
      expect { described_class.new(TestChildModel, YAML) }.to_not raise_error
    end
  end

  describe '#load' do
    subject { described_class.new(TestChildModel, JSON) }

    it 'nil as empty array' do
      expect(subject.load(nil)).to be_empty
    end

    it 'empty string as empty array' do
      expect(subject.load('')).to be_empty
    end

    it 'items as model classes' do
      json = [{ name: 1 }, { name: 2 }].to_json
      arr  = subject.load(json)
      expect(arr.size).to eq 2
      expect(arr[0]).to be_kind_of TestChildModel
      expect(arr[0].name).to eq 1
      expect(arr[1]).to be_kind_of TestChildModel
      expect(arr[1].name).to eq 2
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
    subject { described_class.new(TestChildModel, JSON) }

    it 'array as array' do
      attrs = [TestChildModel.new(name: 1), TestChildModel.new(name: 2)]
      expect(subject.dump(attrs)).to eq [{name: 1}, {name: 2}].to_json
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

  describe 'snake eats tail' do
    it 'JSON dump > load > dump > load > dump' do
      serializer = described_class.new(TestChildModel, JSON)

      attrs = [{ name:1 }, { name:2 }]
      dump1 = attrs.to_json
      load1 = serializer.load(dump1)
      dump2 = serializer.dump(load1)
      load2 = serializer.load(dump2)
      dump3 = serializer.dump(load2)

      expect(dump3).to eq dump1
      expect(load2.collect(&:attributes)).to eq load1.collect(&:attributes)
    end

    it 'YAML dump > load > dump > load > dump' do
      serializer = described_class.new(TestChildModel, YAML)

      attrs = [{ name:1 }, { name:2 }]
      dump1 = attrs.to_yaml
      load1 = serializer.load(dump1)
      dump2 = serializer.dump(load1)
      load2 = serializer.load(dump2)
      dump3 = serializer.dump(load2)

      expect(dump3).to eq dump1
      expect(load2.collect(&:attributes)).to eq load1.collect(&:attributes)
    end
  end

end
