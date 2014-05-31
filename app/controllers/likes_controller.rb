class LikesController < ApplicationController
  def index
    @likes = Like.all
  end

  def create
    @post = Post.find(params[:post_id])
    @like = @post.likes.new
    @like.user = current_user

    flash[:alert] = "You cannot like the same post twice" unless @like.save
    redirect_to posts_path
  end

  # DELETE /posts/:id/likes
  def destroy
    current_user.likes.find(params[:id]).destroy
    redirect_to posts_path
  end
end
