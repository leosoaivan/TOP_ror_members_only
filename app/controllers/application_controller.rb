class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def log_in(user)
    user.remember
    cookies.permanent[:remember_token] = user.remember_token
  end

  def current_user
    @current_user ||= User.find_by(remember_token: cookies[:remember_token])
    return nil unless @current_user
  end
  
  def current_user=(user)
    @current_user = user
  end

  def sign_out
    @current_user = nil
    cookies.delete[:remember_token]
  end

  def logged_in_user
    !@current_user.nil?
  end
  
  
end
