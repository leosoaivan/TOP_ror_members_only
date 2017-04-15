class PostsController < ApplicationController
  before_action :require_login, only: [:new, :create]
  before_action :check_for_cancel, only: [:create]

  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to action: 'index'
    else
      flash[:danger] = custom_error(@post.errors)
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

    def custom_error(errors_hash)
      if errors_hash[:text].join.match?(/blank/)
        "Write something, idiot."
      else
        "You fucked up."
      end
    end

    def check_for_cancel
      if params[:commit] == 'Cancel'
        redirect_to posts_path
      end
    end
    
end
