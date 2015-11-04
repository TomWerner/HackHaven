class SessionsController < ApplicationController
  skip_before_filter :set_current_user
  def new
    # default: render 'new' template
  end
  
  def create
    user = User.authenticate(params[:user][:email], params[:user][:password])
    if user
        session[:session_token] = user.session_token
        flash[:notice] = 'Login successful!'
        redirect_to announcements_path
    else
       flash[:notice] = 'Invalid Password'
       redirect_to login_path
    end
  end
  
  def destroy
    session[:session_token] = nil
    redirect_to announcements_path
  end

end