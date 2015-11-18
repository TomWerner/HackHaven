class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :set_current_user
  before_filter :set_admin

  def set_current_user
    @current_user ||= session[:session_token] && User.find_by_session_token(session[:session_token])
    if @current_user != nil
      @user_message = "Logged in as #{@current_user.name}"
    end
  end
  
  def set_admin
    @admin = 1
    if @current_user != nil
      @admin = @current_user.admin
    end 
  end
  
end
