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
end
