require 'spec_helper'

describe Post do
  let(:post) { Post.create(title: 'Cool post', description: 'Hello world') }

  describe "#tag_names=" do
    context 'no tags' do
      it 'does nothing' do
        post.tag_names = ''
        expect(post.tags).to be_empty
      end
    end
  end
end
