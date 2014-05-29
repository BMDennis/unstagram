require 'spec_helper'

describe 'tagging' do
  before do
    alex = User.create(email: 'alex@alex.com', password: '12345678', password_confirmation: '12345678')
    login_as alex
  end

  it 'displays the tags on the posts page' do
    add_post
    expect(page).to have_link '#yolo'
    expect(page).to have_link '#swag'
  end
end