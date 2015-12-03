class UsersController < ApplicationController
  skip_before_filter :set_current_user, :except => [:index, :edit, :update, :confirm]
  
  def new
    # default: render 'new' template
  end
  
  def create
    user = User.new(:name => params[:user][:name], 
      :email => params[:user][:email], 
      :admin => 1, 
      :password => params[:user][:password],
      :confirmed => false,
      :confirmation_code => SecureRandom.base64)
    if user.save
      flash[:notice] = 'Welcome ' + user.name + '. Your account has been created.' + user.admin.to_s
      session[:session_token] = user.session_token
      
      # Tell the UserMailer to send a welcome email after save
      UserMailer.email_confirmation(user).deliver_later
      
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
  
  def confirm
    user_id = params[:user_id]
    user_code = params[:code]
    user = User.find user_id
    if user == nil or user != @current_user
      flash[:notice] = "Invalid user id"
    else
      if user.confirmation_code == user_code or user.confirmed
        user.confirmation_code = nil
        user.confirmed = true
        user.save
        flash[:notice] = "Email confirmed!"
      else  
        flash[:notice] = "Email confirmation unsuccessful..."
      end
    end
    
    redirect_to '/'
  end

end