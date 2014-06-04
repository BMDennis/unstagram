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
    before { create(:post) }

    it 'displays the posts' do
      visit '/posts'

      expect(page).to have_content 'Cool post'
    end
  end
end

describe 'creating posts' do
  context 'logged out' do
    it  'prompts to sign in' do
      visit '/'
      click_link 'New post'

      expect(page).to have_content 'Sign in'
    end
  end

  context 'logged in' do
    before do
      alex = create(:user)
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
      nico = create(:user)
      login_as nico
      create(:post, title: 'my post', description: 'my description', user: nico)
    end

    it 'is deleted from the posts page' do
      visit '/posts'
      click_link 'Delete'

      expect(page).to have_content 'Post deleted'
    end
  end

  context "not user's post" do
    before do
      nico = create(:user)
      apo = create(:user, email: 'nico@nicasdaso.com')
      create(:post, title: 'my post', description: 'my description', user: apo)

      login_as nico
    end

    it 'has no delete link' do
      visit '/posts'
      expect(page).not_to have_link 'Delete'
    end
  end

  describe "geocode posts" do
    before do
      apo  = create(:user)
      post = create(:post)
      login_as apo
    end

    it "has a map link" do
      visit '/posts'
      click_on "New post"
      fill_in "Address", with: "25 City Road, London"
      click_on "Post it!"

      expect(current_path).to eq "/posts"
      expect(page).to have_content "Map"
    end

    it "doesn't have a map link if there isn't any address" do
      visit '/posts'
      click_on "New post"
      click_on "Post it!"
      expect(page).not_to have_content "Map"
    end
  end
end
