class PostsController < ApplicationController
  before_action :require_login, only: [:new, :create]

  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to action: 'index'
    else
      flash.now[:danger] = @post.errors.full_messages
      redirect_to action: 'new'
    end
  end

  def index
    @posts = Post.all
  end

  private

    def post_params
      params.require(:post).permit(:text)
    end
end
