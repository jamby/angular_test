class PostsController < ApplicationController
  respond_to :json

  def index
    @posts = Post.all

    respond_to do |format|
      format.json { render json: @posts.as_json }
    end
  end

  def create
    @post = Post.create(post_params)

    respond_to do |format|
      format.json { render json: @post.as_json }
    end
  end

  def update
    @post = Post.find(params[:id])
    @post.update_attributes(post_params)

    respond_to do |format|
      format.json { render json: @post.as_json }
    end
  end

private
  def post_params
    params.require(:post).permit(:title, :contents)
  end
end
