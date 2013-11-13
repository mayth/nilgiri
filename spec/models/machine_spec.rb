require 'spec_helper'

describe Machine do
  describe 'create' do
    before do
      Machine.create(
        name: 'sample',
        difficulties: %w(BASIC MEDIUM HARD)
      )
      @machine = Machine.find_by_name('sample')
    end
    subject { @machine }
    context 'when successfully created' do
      it 'has correct name' do
        expect(subject.name).to eq 'sample'
      end
      it 'has correct difficulties' do
        subject.difficulties.should have(3).items
        subject.difficulties[0].should eq('BASIC')
        subject.difficulties[1].should eq('MEDIUM')
        subject.difficulties[2].should eq('HARD')
      end
    end
  end
end
