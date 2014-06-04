class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def new
    @post = Post.new
  end

  def show
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(params[:post].permit(:title, :description, :picture, :tag_names, :address))
    @post.user = current_user
    @post.save!

    redirect_to posts_path
  end

  def index
    @posts = Post.all
    @comment = Comment.new
  end

  def destroy
    @post = current_user.posts.find params[:id]
    @post.destroy

    flash[:notice] = "Post deleted"
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = 'This is not your post!'
  ensure
    redirect_to posts_path
  end
end