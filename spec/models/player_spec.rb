require 'spec_helper'

describe Player do
  before do
    Player.create(
      name: 'maytheplic',
      screen_name: 'Mei Akizuru',
      password: 'password',
      twitter_id: '@maytheplic'
    )
  end
  describe 'create' do
    before do
      @player = Player.find_by_name('maytheplic')
    end
    subject { @player }
    context 'when successfully created' do
      it 'has correct attributes' do
        expect(subject.name).to eq 'maytheplic'
        expect(subject.screen_name).to eq 'Mei Akizuru'
        expect(subject.twitter_id).to eq '@maytheplic'
      end
    end
    context 'when validation is not passed' do
      it 'fails to save' do
        expect(Player.new(name: nil).save).to be_false
        expect(Player.new(name: 'ok').save).to be_false # password must be specified
      end
    end
  end
  describe '#register_score' do
    before do
      Music.create(
        name: 'sample',
        machine: Machine.find_by_name('beatmania IIDX 21 SPADA')
      )
      @music = Music.find_by_name('sample')
      @player = Player.find_by_name('maytheplic')
      season = '201311'
      difficulty = 'HYPER'
      score = 334
      playstyle = 'SP'
      @player.register_score(season, @music, difficulty, score, playstyle)
      @score = Score.where(player_id: @player.id, season: season, music_id: @music.id, difficulty: difficulty, playstyle: playstyle).first
    end
    subject { @score }
    context 'when no scores are registered' do
      it 'correctly adds score' do
        expect(subject).not_to be nil
        expect(subject.season).to eq '201311'
        expect(subject.music).to eq @music
        expect(subject.difficulty).to eq 'HYPER'
        expect(subject.playstyle).to eq 'SP'
        expect(subject.score).to eq 334
      end
    end
    context 'when scores for the same music is registered' do
      before do
        @player.register_score('201311', @music, 'HYPER', 668, 'SP')
        @score = Score.where(player_id: @player.id, season: '201311', music_id: @music.id, difficulty: 'HYPER', playstyle: 'SP').first
      end
      it 'correctly updates score' do
        expect(subject.score).to eq 668
      end
      it 'does nothing for lower score' do
        @player.register_score('201311', @music, 'HYPER', 1, 'SP')
        @score = Score.where(player_id: @player.id, season: '201311', music_id: @music.id, difficulty: 'HYPER', playstyle: 'SP').first
        expect(subject.score).to eq 668
      end
    end
  end
  describe '::authorize' do
    it 'succeeds with valid password' do
      expect(Player.authorize('maytheplic', 'password')).to be_true
    end
    it 'fails with incorrect password' do
      expect(Player.authorize('maytheplic', 'incorrect')).to be_false
    end
    it 'fails if a player is not found' do
      expect(Player.authorize('NOUSER', 'password')).to be_false
    end
  end
end
