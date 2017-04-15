class SessionsController < ApplicationController
  before_action :check_for_cancel, only: [:create]
  
  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      log_in(@user)
      current_user=(@user)

      redirect_to posts_path
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render :new
    end
  end

  def delete
    sign_out
    redirect_to root_url
  end
    
end
