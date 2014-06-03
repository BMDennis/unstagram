require 'spec_helper'

describe 'liking posts' do
  before do
    create(:post)
    login_as create(:user)
  end

  it 'increaments the like count of a post', js: true do
    visit "/"
    sleep 0.1
    click_on "❤ 0"
    expect(page).to have_link "❤ 1"
  end
end