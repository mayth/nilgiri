require 'spec_helper'

describe Music do
  describe 'create' do
    before do
      @machine = Machine.find_by_name('beatmaniaIIDX 21 SPADA')
      Music.create(
        name: 'Critical Crystal',
        artist: '青龍',
        machine: @machine,
        season: '201311'
      )
      @music = Music.find_by_name('Critical Crystal')
    end
    subject { @music }
    context 'when successfully created' do
      it 'has correct name/artist' do
        expect(subject.name).to eq 'Critical Crystal'
        expect(subject.artist).to eq '青龍'
      end
      it 'has correct machine' do
        expect(subject.machine).to eq @machine
      end
      it 'has correct season' do
        expect(subject.season).to eq '201311'
      end
    end
  end
end
