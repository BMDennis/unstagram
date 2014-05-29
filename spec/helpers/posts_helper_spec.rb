require 'spec_helper'

def add_post
  visit '/posts/new'
  fill_in 'Title', with: 'My new post'
  fill_in 'Description', with: 'My description'
  attach_file 'Picture', Rails.root.join('spec/images/old-man1.jpg')
  fill_in 'Tags', with: 'yolo, swag'
  click_button 'Post it!'
end
