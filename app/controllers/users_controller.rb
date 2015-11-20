class UsersController < ApplicationController
  skip_before_filter :set_current_user, :except => [:index, :edit, :update]
  
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
  def edit
    if(@admin == 1)
      redirect_to announcements_path
      return
    end
    @user = User.find params[:id]
    @userAdmin = 1
    if(@user.admin == 0)
      @userAdmin = 0
    end
      
  end
  
  def update
    if(@admin == 1)
      redirect_to announcements_path
      return
    end
    @user = User.find params[:id]
    print params[:user_admin]
    @user.admin = params[:user_admin]
    @user.save
    flash[:notice] = "'#{@user.name}' was successfully updated."
    redirect_to users_path  
  end

end