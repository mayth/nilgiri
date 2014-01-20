require 'spec_helper'

describe Post do
  describe '.create' do
    context 'when valid input is given' do
      it 'should be saved' do
        expect(build(:post).save).to be_true
      end
    end
    context 'when invalid input is given' do
      it 'should not be saved if title is empty' do
        expect(build(:post, title: '').save).to be_false
      end
      it 'should not be saved if body is empty' do
        expect(build(:post, body: '').save).to be_false
      end
    end
  end
end
