require 'spec_helper'

describe Music do
  describe 'create' do
    context 'when the valid input is given' do
      it 'should be saved' do
        expect(build(:music).save).to be_true
      end
    end

    context 'when the invalid input is given' do
      context 'if the name is empty' do
        it 'fails to save' do
          expect(build(:music, name: '').save).to be_false
        end
      end

      context 'if the artist is empty' do
        it 'fails to save' do
          expect(build(:music, artist: '').save).to be_false
        end
      end

      context 'if the season is nil' do
        it 'fails to save' do
          expect(build(:music, season: nil).save).to be_false
        end
      end

      context 'if the machine is nil' do
        it 'fails to save' do
          expect(build(:music, machine: nil).save).to be_false
        end
      end
    end
  end
end
