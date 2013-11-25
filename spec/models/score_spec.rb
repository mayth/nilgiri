require 'spec_helper'

describe Score do
  describe 'create' do
    before do
      @machine = Machine.find_by_name('beatmaniaIIDX 21 SPADA')
      @music = Music.create(
        name: 'Round and Round',
        artist: 'Masayoshi Minoshima',
        machine: @machine
      )
      @player = Player.create(
        name: 'scorespec',
        screen_name: 'ScoreSpec',
        password: 'PASSWORD',
        twitter_id: '@scorespec'
      )
      Score.create(
        season: '201311',
        difficulty: 'HYPER',
        score: 1334.0,
        player: @player,
        music: @music,
        playstyle: 'Single'
      )
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
        expect(subject.playstyle).to eq 'Single'
      end
    end
  end
end
