require 'spec_helper'

describe Machine do
  before do
    Machine.create(
      name: 'sample',
      difficulties: %w(BASIC MEDIUM HARD),
      playstyles: %w(SP DP)
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
      it 'has correct playstyles' do
        expect(subject.playstyles.size).to eq 2
        expect(subject.playstyles).to include 'SP'
        expect(subject.playstyles).to include 'DP'
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
  describe '#valid_playstyle?' do
    before do
      @machine = Machine.find_by_name('sample')
    end
    subject { @machine }
    it 'returns true when correct playstyle is passed' do
      expect(subject.valid_playstyle? 'SP').to be true
      expect(subject.valid_playstyle? 'DP').to be true
    end
    it 'returns false when invalid playstyle is passed' do
      expect(subject.valid_playstyle? 'GUITAR').to be false
      expect(subject.valid_playstyle? 'BASS').to be false
    end
    it 'returns false when no playstyles available' do
      machine = Machine.create(name: 'sample2')
      expect(machine.valid_playstyle? 'SP').to be false
    end
  end
end
