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
      it 'should not be saved if slug is empty' do
        expect(build(:post, slug: '').save).to be_false
      end
      it 'should not be saved if slug is invalid' do
        expect(build(:post, slug: 'a-12%001a').save).to be_false
      end
    end
  end

  describe '#slug_candidate' do
    before do
      @post = create(:post)
    end
    subject { @post.slug_candidate }

    it 'returns correct value' do
      expect(subject).to eq @post.title.parameterize
    end
  end
end
