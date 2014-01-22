require 'spec_helper'

describe Player do
  describe '#create' do
    context 'when valid input is given' do
      before do
        @player = build(:player)
      end
      subject { @player }
      it 'should be saved correctly' do
        expect(subject.save).to be_true
      end
    end
    context 'when invalid input is given' do
      it 'should fail if name is empty' do
        expect(build(:player, name: '').save).to be_false
      end
      it 'should fail if password is empty' do
        p = build(:player)
        p.password = ''
        expect(p.save).to be_false
      end
    end
  end

  describe '#register_score' do
    before do
      @player = create(:player)
      @season = create(:season)
      @music = create(:music)
    end
    subject { @score }

    context 'when no scores are registered' do
      before do
        @score = @player.register_score(season: @season, music: @music, difficulty: 'HARD', score: 334, playstyle: 'SP')
        @score.save!
      end
      it 'correctly adds score' do
        expect(subject).not_to be nil
        expect(subject.season).to eq @season
        expect(subject.music).to eq @music
        expect(subject.difficulty).to eq 'HARD'
        expect(subject.playstyle).to eq 'SP'
        expect(subject.score).to eq 334
      end
    end
    context 'when scores for the same music is registered' do
      before do
        @score = @player.register_score(season: @season, music: @music, difficulty: 'HARD', score: 334, playstyle: 'SP')
        @score.save!
      end

      context 'if the score is greater than before' do
        before do
          @score = @player.register_score(season: @season, music: @music, difficulty: 'HARD', score: 668, playstyle: 'SP')
          @score.save!
        end
        it 'updates score' do
          expect(subject.score).to eq 668
        end
      end

      context 'if the score is lower than before' do
        before do
          @score = @player.register_score(season: @season, music: @music, difficulty: 'HARD', score: 1, playstyle: 'SP')
          @score.save!
        end
        it 'does nothing' do
          expect(subject.score).not_to eq 1
        end
      end
    end
  end
end
