require 'spec_helper'

describe Machine do
  describe '#valid_difficulty?' do
    before do
      @machine = create(:machine)
    end
    subject { @machine }

    context 'when correct difficulties are passed' do
      it 'returns true for them' do
        expect(subject.valid_difficulty? 'BASIC').to be true
        expect(subject.valid_difficulty? 'MEDIUM').to be true
        expect(subject.valid_difficulty? 'HARD').to be true
      end
    end

    context 'when invalid difficulties are passed' do
      it 'returns false for them' do
        expect(subject.valid_difficulty? 'NORMAL').to be false
        expect(subject.valid_difficulty? 'HYPER').to be false
        expect(subject.valid_difficulty? 'ANOTHER').to be false
      end
    end
  end

  describe '#valid_playstyle?' do
    before do
      @machine = create(:machine)
    end
    subject { @machine }

    context 'when the machine has some playstyles' do
      it 'returns true when correct playstyle is passed' do
        expect(subject.valid_playstyle? 'SP').to be true
        expect(subject.valid_playstyle? 'DP').to be true
      end
      it 'returns false when invalid playstyle is passed' do
        expect(subject.valid_playstyle? 'GUITAR').to be false
        expect(subject.valid_playstyle? 'BASS').to be false
      end
    end

    context 'when the machine has no playstyles' do
      before do
        @machine = create(:machine, playstyles: nil)
      end
      it 'returns false if some playstyle is passed' do
        expect(subject.valid_playstyle? 'SP').to be false
      end
      it 'returns true if no playstyle is passed' do
        expect(subject.valid_playstyle? '').to be true
        expect(subject.valid_playstyle? nil).to be true
      end
    end
  end
end
