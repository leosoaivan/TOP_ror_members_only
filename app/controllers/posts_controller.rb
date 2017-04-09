class PostsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create]

  def new
    render :new
  end

  def create
    @post = Post.new(params[:text, user_id: current_user])
    if @post
      @post.save
      redirect_to 'index'
    end
  end

  def index
  end
end
