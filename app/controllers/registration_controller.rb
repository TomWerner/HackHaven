class RegistrationController < ApplicationController
    
  def registration_params
    params.require(:registration).permit(:userid, :contestname, :email, :firstname, :lastname, :email, :year, :major)
  end

  def index
    if @current_user != nil
     @registrations = Registration.order(:created_at => :desc).where(:userid => @current_user.id)
    else
      @registrations = nil
    end
  end

  def edit
    @registration = Registration.find params[:id]
  end

  def new
    if @current_user != nil
     @currentuserid = @current_user.id;
    else
     @currentuserid = nil
    end
    
    if Contest.all.blank?
      @contests_blank = true
    else
      @contests_blank = false
    end
  end
  
  def update
    @registration = Registration.find params[:id]
    @registration.update_attributes!(registration_params)
    flash[:notice] = "Registration for #{@registration.firstname} was successfully updated."
    redirect_to :action => "index"
  end

  def create
    if (@registration = Registration.new(registration_params)).valid?
      @registration.save!
      flash[:notice] = "Registration for #{@registration.firstname} was successfully created."
      redirect_to :action => "index"
    else
      flash[:warning] = "Registration was not created. Please fix errors #{@registration.errors.full_messages}"
      render :action => "new"
    end
  end
end
