require 'spec_helper'

describe Score do
  before :all do
    @season = Season.create(
      name: "season #{rand}",
      start: Time.now,
      expiry: Time.now.next_month
    )
    @machine = Machine.find_by_name('beatmania IIDX 21 SPADA')
    @music = @machine.musics.create(
      name: 'Round and Round',
      artist: 'Masayoshi Minoshima',
      season: @season
    )
    @music.save!
    @player = Player.create(
      name: 'scorespec',
      screen_name: 'ScoreSpec',
      password: 'PASSWORD',
      twitter_id: '@scorespec'
    )
    @player.save!
    @player.register_score(
      @season,
      @music,
      'HYPER',
      1334,
      'SP'
    ).save!
  end
  describe 'create' do
    before do
      @score = @player.scores.where(season_id: @season.id).first
    end
    subject { @score }
    context 'when successfully created' do
      it 'has correct attributes' do
        expect(subject.season).to eq @season
        expect(subject.difficulty).to eq 'HYPER'
        expect(subject.score).to eq 1334
        expect(subject.player).to eq @player
        expect(subject.music).to eq @music
        expect(subject.playstyle).to eq 'SP'
      end
    end
  end
  describe '::new' do
    context 'when validation fails' do
      it 'is not saved' do
        expect(Score.new(season: nil).save).to be_false
        expect(Score.new(
          season: @season,
          difficulty: 'BASIC', # invalid
          score: 1334,
          player: @player,
          music: @music,
          playstyle: 'SP'
        ).save).to be_false
        expect(Score.new(
          season: @season,
          difficulty: 'HYPER',
          score: -10, # invalid
          player: @player,
          music: @music,
          playstyle: 'SP'
        ).save).to be_false
        expect(Score.new(
          season: @season,
          difficulty: 'HYPER',
          score: 334,
          player: nil,
          music: @music,
          playstyle: 'SP'
        ).save).to be_false
        expect(Score.new(
          season: @season,
          difficulty: 'HYPER',
          score: 334,
          player: @player,
          music: nil,
          playstyle: 'SP'
        ).save).to be_false
        expect(Score.new(
          season: @season,
          difficulty: 'HYPER',
          score: 334,
          player: @player,
          music: @music,
          playstyle: 'GUITAR'
        ).save).to be_false
      end
    end
  end

  describe '.top_scores' do
    before do
      @player2 = Player.create(
        name: 'scorespec2',
        screen_name: 'ScoreSpec2',
        password: 'PASSWORD',
        twitter_id: '@scorespec2'
      )
      s = @player2.register_score(
        @season,
        @music,
        'HYPER',
        114514,
        'SP'
      )
      @scores = [s, @player.scores.where(season_id: @season.id).first]
      @actual = Score.top_scores(@music, 'HYPER', 'SP')
    end
    it 'returns scores sorted by scores in descending order' do
      expect(@actual[0]).to eq @scores[0]
      expect(@actual[1]).to eq @scores[1]
    end
  end
end
