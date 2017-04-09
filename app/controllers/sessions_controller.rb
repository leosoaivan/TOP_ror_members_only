class SessionsController < ApplicationController
  
  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      log_in(@user)
      current_user=(@user)

      redirect_to posts_new_path
    else
      flash[:warning] = 'Invalid email/password combination'
      render :new
    end
  end

  def delete
    sign_out
    redirect_to root_url
  end
    
end
