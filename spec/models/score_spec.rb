require 'spec_helper'

describe Score do
  before :all do
    @machine = Machine.find_by_name('beatmania IIDX 21 SPADA')
    @music = @machine.musics.create(
      name: 'Round and Round',
      artist: 'Masayoshi Minoshima'
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
      '201311',
      @music,
      'HYPER',
      1334,
      'SP'
    ).save!
  end
  describe 'create' do
    before do
      @score = @player.scores.where(season: '201311').first
    end
    subject { @score }
    context 'when successfully created' do
      it 'has correct attributes' do
        expect(subject.season).to eq '201311'
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
          season: '201311',
          difficulty: 'BASIC', # invalid
          score: 1334,
          player: @player,
          music: @music,
          playstyle: 'SP'
        ).save).to be_false
        expect(Score.new(
          season: '201311',
          difficulty: 'HYPER',
          score: -10, # invalid
          player: @player,
          music: @music,
          playstyle: 'SP'
        ).save).to be_false
        expect(Score.new(
          season: '201311',
          difficulty: 'HYPER',
          score: 334,
          player: nil,
          music: @music,
          playstyle: 'SP'
        ).save).to be_false
        expect(Score.new(
          season: '201311',
          difficulty: 'HYPER',
          score: 334,
          player: @player,
          music: nil,
          playstyle: 'SP'
        ).save).to be_false
        expect(Score.new(
          season: '201311',
          difficulty: 'HYPER',
          score: 334,
          player: @player,
          music: @music,
          playstyle: 'GUITAR'
        ).save).to be_false
      end
    end
  end
end
