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
    before(:each) { Post.create(title: 'Cool post', description: 'Hello world') }

    it 'displays the posts' do
      visit '/posts'

      expect(page).to have_content 'Cool post'
    end
  end
end

describe 'creating posts' do
  context 'logged out' do
    it  'prompts to sign in' do
      visit '/posts'
      click_link 'New post'

      expect(page).to have_content 'Sign in'
    end
  end

  context 'logged in' do
    before do
      alex = User.create(email: 'alex@alex.com', password: '12345678', password_confirmation: '12345678')
      login_as alex
    end

    it 'adds the post to the homepage' do
      visit '/posts/new'
      fill_in 'Title', with: 'My new post'
      fill_in 'Description', with: 'description'
      attach_file 'Picture', Rails.root.join('spec/images/old-man1.jpg')

      click_button 'Post it!'

      expect(current_path).to eq posts_path
      expect(page).to have_content 'My new post'
      expect(page).to have_css 'img.uploaded-pic'
    end
  end
end


describe 'deleting posts' do
  context "user's post" do
    before do
      nico = User.create(email: 'nico@nico.com', password: '12345678', password_confirmation: '12345678')
      login_as nico
      Post.create(title: 'my post', description: 'my description', user: nico)
    end

    it 'is deleted from the posts page' do
      visit '/posts'
      click_link 'Delete'

      expect(page).to have_content 'Post deleted'
    end
  end

  context "not user's post" do
    before do
      nico = User.create(email: 'nico@nico.com', password: '12345678', password_confirmation: '12345678')
      apo  = User.create(email: 'nico@nicasdaso.com', password: '12345678', password_confirmation: '12345678')
      Post.create(title: 'my post', description: 'my description', user: apo)

      login_as nico
    end

    it 'has no delete link' do
      visit '/posts'
      expect(page).not_to have_link 'Delete'
    end
  end
end
