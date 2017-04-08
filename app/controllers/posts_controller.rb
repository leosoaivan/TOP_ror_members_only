class PostsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :index]

  def new
    render :new
  end

  def create
    @post = Post.new(params[:text, user_id: current_user])
  end

  def index
  end
end
