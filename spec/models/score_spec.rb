require 'spec_helper'

describe Score do
  describe 'create' do
    context 'when the valid input is given' do
      it 'should be saved' do
        expect(build(:score).save).to be_true
      end
    end

    context 'when the invalid input is given' do
      context 'if the playstyle is nil for the machine which has playstyles' do
        it 'fails to save' do
          expect(build(:score, playstyle: nil).save).to be_false
        end
      end
      context 'if the invalid playstyle is passed' do
        it 'fails to save' do
          expect(build(:score, playstyle: 'AAAA').save).to be_false
        end
      end
      context 'if the playstyle is given for the machine which has no playstyles' do
        before do
          m = create(:machine, playstyles: nil)
          @music = create(:music, machine: m)
        end
        it 'fails to save' do
          expect(build(:score, music: @music, playstyle: 'SP').save).to be_false
        end
      end
      context 'if difficulty is nil' do
        it 'fails to save' do
          expect(build(:score, difficulty: nil).save).to be_false
        end
      end
      context 'if difficulty is invalid' do
        it 'fails to save' do
          expect(build(:score, difficulty: 'AAAA').save).to be_false
        end
      end
      context 'if score is nil' do
        it 'fails to save' do
          expect(build(:score, score: nil).save).to be_false
        end
      end
      context 'if score is negative integer' do
        it 'fails to save' do
          expect(build(:score, score: -1).save).to be_false
        end
      end
      context 'if player is nil' do
        it 'fails to save' do
          expect(build(:score, player: nil).save).to be_false
        end
      end
      context 'if music is nil' do
        it 'fails to save' do
          expect(build(:score, music: nil).save).to be_false
        end
      end
      context 'if season is nil' do
        it 'fails to save' do
          expect(build(:score, season: nil).save).to be_false
        end
      end
    end
  end
end
