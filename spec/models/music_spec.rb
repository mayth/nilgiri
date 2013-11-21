require 'spec_helper'

describe Music do
  describe 'create' do
    before do
      @machine = Machine.find_by_name('beatmaniaIIDX 21 SPADA')
      Music.create(
        name: 'Critical Crystal',
        machine: @machine
      )
      @music = Music.find_by_name('Critical Crystal')
    end
    subject { @music }
    context 'when successfully created' do
      it 'has correct name' do
        expect(subject.name).to eq 'Critical Crystal'
      end
      it 'has correct machine' do
        expect(subject.machine).to eq @machine
      end
    end
  end
end
