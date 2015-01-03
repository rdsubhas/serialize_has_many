require 'spec_helper'

describe SerializeHasMany::Collection do

  describe '#new' do
    it { expect(described_class.new(AttrStruct, nil)).to be_empty }
    it { expect(described_class.new(AttrStruct, [])).to be_empty }

    it { expect { described_class.new(AttrStruct, {}) }.to raise_error(/items is not an array/) }
    it { expect { described_class.new(AttrStruct, '#BLAH#') }.to raise_error(/items is not an array/) }
  end

  describe '#delegates' do
    subject { described_class.new(AttrStruct, [{a: 1}, {b: 2}, {c: 3}]) }

    it { expect(subject.size).to eq 3 }
    it { expect(subject.count).to eq 3 }
    it { expect(subject).to be_present }
    it { expect(subject).to_not be_empty }
    it { expect(subject).to_not be_blank }
    it { expect(subject[0].a).to eq 1 }
    it { expect(subject[1].b).to eq 2 }
    it { expect(subject[2].c).to eq 3 }
    it { expect { |b| subject.each(&b) }.to yield_control.exactly(3).times }
  end

  describe '#[]' do
    subject { described_class.new(AttrStruct, []) }

    it 'should accept same type' do
      i = AttrStruct.new({a: 1})
      subject[0] = i
      expect(subject[0]).to be i
    end

    it 'should accept nil' do
      subject[0] = nil
      expect(subject[0]).to be_nil
    end

    it 'should accept hash' do
      subject[0] = {a: 1}
      expect(subject[0]).to be_kind_of AttrStruct
      expect(subject[0].a).to eq 1
    end

    it 'should reject anything else' do
      expect { subject[0] = 1 }.to raise_error(/item not type of/)
      expect { subject[0] = 'a' }.to raise_error(/item not type of/)
      expect { subject[0] = [] }.to raise_error(/item not type of/)
    end
  end

  describe '#<<' do
    subject { described_class.new(AttrStruct, []) }

    it 'should accept same type' do
      i = AttrStruct.new({a: 1})
      subject << i
      expect(subject[0]).to be i
    end

    it 'should accept nil' do
      subject << nil
      expect(subject[0]).to be_nil
    end

    it 'should accept hash' do
      subject << {a: 1}
      expect(subject[0]).to be_kind_of AttrStruct
      expect(subject[0].a).to eq 1
    end

    it 'should reject anything else' do
      expect { subject << 1 }.to raise_error(/item not type of/)
      expect { subject << 'a' }.to raise_error(/item not type of/)
      expect { subject << [] }.to raise_error(/item not type of/)
    end
  end

end
