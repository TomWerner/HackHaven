class AnnouncementsController < ApplicationController

  def set_current_user
    @current_user ||= session[:session_token] && User.find_by_session_token(session[:session_token])
  end
  
  def announcement_params
    params.require(:announcement).permit(:title, :content)
  end

  def index
    @announcements = Announcement.order(:created_at => :desc)
    
  end

  def edit
    require_admin
    @announcement = Announcement.find params[:id]
  end

  def new
    require_admin
    #just displays the new template
  end
  
  def update
    require_admin
    @announcement = Announcement.find params[:id]
    @announcement.update_attributes!(announcement_params)
    flash[:notice] = "'#{@announcement.title}' was successfully updated."
    redirect_to announcements_path
  end

  def create
    require_admin
    @announcement = Announcement.create!(announcement_params)
    flash[:notice] = "'#{@announcement.title}' was successfully created."
    redirect_to announcements_path
  end
  
  def destroy
    require_admin
    @announcement = Announcement.find(params[:id])
    @announcement.destroy
    flash[:notice] = "'#{@announcement.title}' was successfully deleted."
    redirect_to announcements_path
  end
end
