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

  describe '.get_top_scores' do
    context 'if valid args are given' do
      context 'if some scores available' do
        before do
          @music = create(:music)
          @difficulty = @music.machine.difficulties.sample
          @playstyle = @music.machine.playstyles.sample
          @players = 5.times.map { create(:player) }
          @scores = [100, 300, 200, 600, 200]
          5.times {|n|
            create(:score, music: @music, difficulty: @difficulty, playstyle: @playstyle,
              player: @players[n], score: @scores[n])
          }
        end
        subject { Score.get_top_scores(@music, @difficulty, playstyle: @playstyle, num: 3) }
        it 'returns top scores' do
          expect(subject.pluck(:score)).to eq @scores.sort.reverse.take(3)
        end

        context 'for the machine which has no playstyles' do
          before do
            machine = create(:machine, playstyles: nil)
            @music = create(:music, machine: machine)
            @difficulty = @music.machine.difficulties.sample
            @scores = [1100, 1300, 1200, 1600, 1200]
            5.times {|n|
              create(:score, music: @music, difficulty: @difficulty, playstyle: nil,
                player: @players[n], score: @scores[n])
            }
          end
          subject { Score.get_top_scores(@music, @difficulty, num: 3) }
          it 'returns top scores' do
            expect(subject.pluck(:score)).to eq @scores.sort.reverse.take(3)
          end
        end
      end
      context 'if no scores available' do
        before do
          @music = create(:music)
          @difficulty = @music.machine.difficulties.sample
          @playstyle = @music.machine.playstyles.sample
        end
        subject { Score.get_top_scores(@music, @difficulty, playstyle: @playstyle, num: 3) }
        it 'returns nothing' do
          expect(subject.present?).to be_false
        end
      end
    end
    context 'if invalid args are given' do
      before do
          @music = create(:music)
          @difficulty = @music.machine.difficulties.sample
          @playstyle = @music.machine.playstyles.sample
      end
      context 'if music is nil' do
        subject { Score.get_top_scores(nil, @difficulty, playstyle: @playstyle) }
        it 'fails with ArgumentError' do
          expect{subject}.to raise_error(ArgumentError)
        end
      end
      context 'if difficulty is nil' do
        subject { Score.get_top_scores(@music, nil, playstyle: @playstyle) }
        it 'fails with ArgumentError' do
          expect{subject}.to raise_error(ArgumentError)
        end
      end
      context 'if playstyle is nil for the machine which has playstyles' do
        subject { Score.get_top_scores(@music, @difficulty) }
        it 'fails with ArgumentError' do
          expect{subject}.to raise_error(ArgumentError)
        end
      end
      context 'if playstyle is passed for the machine which has no playstyles' do
        before do
          machine = create(:machine, playstyles: nil)
          @music = create(:music, machine: machine)
          @playstyle = 'SP'
        end
        subject { Score.get_top_scores(@music, @difficulty, playstyle: @playstyle) }
        it 'fails with ArgumentError' do
          expect{subject}.to raise_error(ArgumentError)
        end
      end
    end
  end
end
