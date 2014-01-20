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
