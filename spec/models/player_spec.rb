require 'spec_helper'

describe Player do
  before do
    Player.create(
      name: 'maytheplic',
      screen_name: 'Mei Akizuru',
      password: 'HASHED_PASSWORD',
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
        expect(subject.password).to eq 'HASHED_PASSWORD'
        expect(subject.twitter_id).to eq '@maytheplic'
      end
    end
  end
end
