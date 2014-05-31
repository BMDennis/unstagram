class TagsController < ApplicationController
  # GET /tags/:id
  def show
    @tag = Tag.find(params[:id])
    @posts = @tag.posts
  end
end
