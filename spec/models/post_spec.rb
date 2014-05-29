require 'spec_helper'

describe Post do
  let!(:post) { Post.create(title: 'Cool post', description: 'Hello world') }

  describe "#tag_names=" do
    context 'no tags' do
      it 'does nothing' do
        post.tag_names = ''
        expect(post.tags).to be_empty
      end
    end

    context 'adding tags' do
      it 'adds a single tag to the post' do
        post.tag_names = 'yolo'
        expect(post.tags.count).to eq 1
      end

      it 'prepends the tag with a #' do
        post.tag_names = 'yolo'
        tag = post.tags.last
        expect(tag.name).to eq '#yolo'
      end

      it "doesn't add a '#' if there is one" do
        post.tag_names = '#yolo'
        tag = post.tags.last

        expect(tag.name).to eq '#yolo'
      end

      it 'comma-separated tags' do
        post.tag_names = 'yolo, swag'
        expect(post.tags.count).to eq 2
      end
    end

    context 'reuses existing tags' do
      let!(:tag) { Tag.create(name: '#yolo') }

      it 'reuses tags if they exist' do
        post.tag_names = 'yolo'
        expect(Tag.count).to eq 1

        expect(tag.posts).to include post
      end
    end

    context 'validate uniqueness' do
      it 'uses only unique tags' do
        post.tag_names = 'yolo, swag, yolo'
        expect(post.tags.count).to eq 2
      end
    end
  end
end