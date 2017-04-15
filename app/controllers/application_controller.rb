class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def log_in(user)
    remember_token = user.remember_token
    cookies.permanent[:remember_token] = remember_token
    user.update_attribute(:remember_digest, User.new_digest(remember_token))
    self.current_user = user
  end

  def current_user
    remember_token = User.new_digest(cookies[:remember_token])
    @current_user ||= User.find_by(remember_digest: remember_token)
    return nil unless @current_user
    @current_user
  end
  
  def current_user=(user)
    @current_user = user
  end

  def sign_out
    @current_user = nil
    cookies.delete :remember_digest
    cookies.delete :remember_token
  end

  def logged_in?
    !!@current_user
  end

  def require_login
    unless logged_in?
      flash[:danger] = "You must be logged in to access this section"
      redirect_to login_path
    end
  end
  
end
