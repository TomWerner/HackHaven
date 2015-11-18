class UsersController < ApplicationController
  skip_before_filter :set_current_user, :except => [:index]
  def new
    # default: render 'new' template
  end
  
  def create
    user = User.new(:name => params[:user][:name], :email => params[:user][:email], :admin => 1, :password => params[:user][:password])
    if user.save
      flash[:notice] = 'Welcome ' + user.name + '. Your account has been created.' + user.admin.to_s
      session[:session_token] = user.session_token
      redirect_to announcements_path
    else
      flash[:notice] = 'Sorry, user creation failed'
      redirect_to new_user_path
    end
  end
  
  def index
     if(@admin == 1)
      redirect_to announcements_path
     return
    end
    @users = User.order(:name => :desc)
    
  end

end