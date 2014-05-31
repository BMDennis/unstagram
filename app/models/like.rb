class Like < ActiveRecord::Base
  belongs_to :user
  belongs_to :post

  validates :user, uniqueness: { scope: :post, message: "You can't like the same post twice" }
end
