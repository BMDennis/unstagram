require 'spec_helper'

describe 'like posts' do
  context 'on default' do
    specify 'a post has no likes' do
      visit '/posts'

      expect(page).not_to have_content 'Likes'
    end
  end

  context 'adding likes' do
    before do
      apo = User.create(email: "apos@apos.com", password: "12345678", password_confirmation: "12345678")
      Post.create(title: 'my post', description: 'my description')
      login_as apo
    end

    it 'can add a like to a post' do
      visit '/posts'
      click_on 'Like'

      expect(current_path).to eq posts_path
      expect(page).to have_content 'apos@apos.com likes this'
    end
  end
end
