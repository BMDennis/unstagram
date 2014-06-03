require 'spec_helper'

describe 'comments' do
  before do
    apo = create(:user)
    login_as apo
  end

  context 'adding comments' do
    before { create(:post) }

    it "there isn't any" do
      visit '/'
      expect(page).to have_content 'No comments yet'
    end

    it "can be added to the post" do
      visit '/'
      # click_on "Leave a comment"
      puts page.source
      fill_in "Comment", with: "be nice"
      click_on "Add comment"

      expect(page).to have_content "be nice"
      expect(page).to have_content "1 comment from apo"
    end
  end
end