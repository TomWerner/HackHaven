class RegistrationController < ApplicationController
    def registration_params
    params.require(:registration).permit(:userid, :contestname, :email, :firstname, :lastname)
  end

  def index
    @regstrations = Registration.order(:created_at => :desc)
  end

  def edit
    @registration = Registration.find params[:id]
  end

  def new
    #FOR when there's a user table
    #@currentuser = User.find session[:user_id]
    @currentuserid = 1;
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
