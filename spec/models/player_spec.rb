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
        expect(build(:player, password: '').save).to be_false
      end
      it 'should fail if name is invalid' do
        expect(build(:player, name: '--a').save).to be_false
      end
    end
  end

  describe '#screen_name' do
    context 'when the player has a screen name' do
      before do
        @player = create(:player)
      end
      subject { @player }
      it 'returns screen name' do
        expect(subject.screen_name).to eq '秋弦めい'
      end
    end

    context 'when the player has no screen name' do
      before do
        @player = create(:player, screen_name: nil)
      end
      subject { @player }
      it 'returns name' do
        expect(subject.screen_name).to eq subject.name
      end
    end
  end

  describe '.authorize' do
    before do
      @player = create(:player)
    end

    it 'succeeds with valid password' do
      expect(Player.authorize(@player.name, 'pwpwpwpw')).to be_true
    end

    it 'fails with incorrect password' do
      expect(Player.authorize(@player.name, 'qmqmqmqm')).to be_false
    end

    it 'fails if a player is not found' do
      expect(Player.authorize('kogasa-chan', 'kawaii')).to be_false
    end
  end
end
