require 'spec_helper'

describe 'tagging' do
  before do
    alex = User.create(email: 'alex@alex.com', password: '12345678', password_confirmation: '12345678')
    login_as alex
  end

  it 'displays the tags on the posts page' do
    visit '/posts/new'
    fill_in 'Title', with: 'My new post'
    fill_in 'Description', with: 'My description'
    attach_file 'Picture', Rails.root.join('spec/images/old-man1.jpg')
    fill_in 'Tags', with: 'yolo, swag'
    click_button 'Post it!'

    expect(page).to have_link '#yolo'
    expect(page).to have_link '#swag'
  end
end