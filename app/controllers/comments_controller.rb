class CommentsController < ApplicationController
  def new
    @post    = Post.find(params[:post_id])
    @comment = Comment.new
  end

  def create
    @post         = Post.find(params[:post_id])
    @comment      = @post.comments.new(params[:comment].permit(:comment))
    @comment.user = current_user
    @comment.save!

    # redirect_to '/posts'

    render 'create', content_type: :json
  end
end