require 'spec_helper'

describe Post do
  describe 'create' do
    before do
      Post.create(
        title: 'EXCELLENT!',
        body: "You're excellent player!"
      )
      @post = Post.last
    end
    subject { @post }
    context 'created successfully' do
      it 'has correct attributes' do
        expect(subject.title).to eq 'EXCELLENT!'
        expect(subject.body).to eq "You're excellent player!"
      end
    end
  end
  describe '#truncated_body' do
    before do
      @post = Post.create(
        title: 'truncate_sample',
        body: 'The quick brown fox jumps over the lazy dog'
      )
    end
    subject { @post }
    it 'does not affect if the body is shorter than the given length' do
      expect(subject.truncated_body(length: 100)).to eq subject.body
      expect(subject.truncated_body(length: 100).length).to eq subject.body.length
    end
    it 'cuts the given length' do
      expect(subject.truncated_body(length: 10, omission: '...')).to eq 'The qui...'
      expect(subject.truncated_body(length: 10, omission: '...').length).to eq 10
    end
  end
end
