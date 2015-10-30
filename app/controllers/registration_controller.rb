class RegistrationController < ApplicationController
  before_filter :set_current_user
    
  def registration_params
    params.require(:registration).permit(:userid, :contestname, :email, :firstname, :lastname, :email, :year)
  end

  def index
    if @current_user != nil
     @registrations = Registration.order(:created_at => :desc).where(:userid => @current_user.id)
   end
  end

  def edit
    @registration = Registration.find params[:id]
  end

  def new
    if @current_user != nil
     @currentuserid = @current_user.id;
    end
  end
  
  def update
    @registration = Registration.find params[:id]
    @regitstration.update_attributes!(registration_params)
    flash[:notice] = "Registration for #{@registration.firstname} was successfully updated."
    redirect_to registration_path
  end

  def create
    @registration = Registration.create!(registration_params)
    flash[:notice] = "Registration for #{@registration.firstname} was successfully created."
    redirect_to :action => "index"
  end
end
