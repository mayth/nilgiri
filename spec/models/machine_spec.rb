require 'spec_helper'

describe Machine do
  before do
    Machine.create(
      name: 'sample',
      difficulties: %w(BASIC MEDIUM HARD),
      playstyles: %w(SP DP),
      slug: 'sample'
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
      it 'has correct slug' do
        expect(subject.slug).to eq 'sample'
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
    subject { @machine }
    context 'when the machine has some playstyles' do
      before do
        @machine = Machine.find_by_name('sample')
      end
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
        @machine = Machine.create(name: 'sample2')
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

  describe '#musics_for' do
    before do
      t = Time.now
      @season = Season.create(
        name: 'Musics For Season 1',
        start: t,
        expiry: t.next_month
      )
      @machine = Machine.find(1)
      @machine.musics.create(
        name: 'Machine Control Music',
        artist: 'Dove',
        season: @season
      )
      @machine.musics.create(
        name: 'Machine Control Music 2',
        artist: 'Dove 2',
        season: @season
      )
    end
    subject { @machine.musics_for(@season) }
    it 'returns correct array' do
      expect(subject.size).to eq 2
      expect(subject[0].name).to eq 'Machine Control Music'
      expect(subject[0].artist).to eq 'Dove'
      expect(subject[0].season).to eq @season
      expect(subject[1].name).to eq 'Machine Control Music 2'
      expect(subject[1].artist).to eq 'Dove 2'
      expect(subject[1].season).to eq @season
    end
  end
end
