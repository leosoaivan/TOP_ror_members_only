class SessionsController < ApplicationController
  
  def new
    render :new
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(password: params[:session][:password])
      log_in(@user)
      current_user(@user)
      
      redirect_to root_url
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
