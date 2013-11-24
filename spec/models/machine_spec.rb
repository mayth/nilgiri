require 'spec_helper'

describe Machine do
  before do
    Machine.create(
      name: 'sample',
      difficulties: %w(BASIC MEDIUM HARD)
    )
  end
  describe 'create' do
    before do
      @machine = Machine.find_by_name('sample')
    end
    subject { @machine }
    context 'when successfully created' do
      it 'has correct name' do
        expect(subject.name).to eq 'sample'
      end
      it 'has correct difficulties' do
        subject.difficulties.should have(3).items
        subject.difficulties[0].should eq('BASIC')
        subject.difficulties[1].should eq('MEDIUM')
        subject.difficulties[2].should eq('HARD')
      end
    end
  end

  describe '#valid_difficulty?' do
    before do
      @machine = Machine.find_by_name('sample')
    end
    subject { @machine }
    it 'returns true when correct difficulty is passed' do
      expect(subject.valid_difficulty? 'BASIC').to be true
      expect(subject.valid_difficulty? 'MEDIUM').to be true
      expect(subject.valid_difficulty? 'HARD').to be true
    end
    it 'returns false when invalid difficulty is passed' do
      expect(subject.valid_difficulty? 'NORMAL').to be false
      expect(subject.valid_difficulty? 'HYPER').to be false
      expect(subject.valid_difficulty? 'ANOTHER').to be false
    end
  end
end
