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
  end
  
  def update
    @registration = Registration.find params[:id]
    @registration.update_attributes!(registration_params)
    flash[:notice] = "Registration for #{@registration.firstname} was successfully updated."
    redirect_to :action => "index"
  end

  def create
    @registration = Registration.create!(registration_params)
    flash[:notice] = "Registration for #{@registration.firstname} was successfully created."
    redirect_to :action => "index"
  end
end
