require 'spec_helper'

  describe 'posts' do
    context 'no posts' do
      it 'displays a message' do
        visit '/posts'

        expect(page).to have_content "No posts"
        expect(page).to have_content "New post"
      end
    end

    context 'with posts' do
      it 'displays the posts' do
        visit '/posts'

        Post.create(title: 'Cool post', description: 'Hello world')
        expect(page).to have_content 'Cool post'
      end
    end
  end

  describe 'adding posts' do
    it 'adds the post to the homepage' do
      visit '/posts/new'
      fill_in 'Title', with: 'My new post'
      fill_in 'Description', with: 'description'
      attach_file 'Picture', Rails.root.join('spec/images/old-man1.jpg')

      click_button 'Post it!'

      expect(current_path).to eq posts_path
      expect(page).to have_content 'My new post'
      expect(page).to have_content 'img.uploaded-pic'
    end
  end




