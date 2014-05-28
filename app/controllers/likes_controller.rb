class LikesController < ApplicationController
  def index
    @likes = Like.all
  end

  def create
    @post = Post.find(params[:post_id])
    @like = @post.likes.new
    @like.user = current_user
    @like.save
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = 'You need to sign in first.'
  ensure
    redirect_to posts_path
  end
end
