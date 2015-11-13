class AnnouncementsController < ApplicationController
  
  def set_current_user
    @current_user ||= session[:session_token] && User.find_by_session_token(session[:session_token])
  end
  
  def announcement_params
    params.require(:announcement).permit(:title, :content)
  end

  def index
    @announcements = Announcement.order(:created_at => :desc)
    @admin = 1
    if @current_user != nil
      @admin = @current_user.admin
    end 
  end

  def edit
     if(@current_user.admin == 1)
      redirect_to announcements_path
     end
    @announcement = Announcement.find params[:id]
  end

  def new
     if(@current_user.admin == 1)
      redirect_to announcements_path
     end
    #just displays the new template
  end
  
  def update
     if(@current_user.admin == 1)
      redirect_to announcements_path
     end
    @announcement = Announcement.find params[:id]
    @announcement.update_attributes!(announcement_params)
    flash[:notice] = "'#{@announcement.title}' was successfully updated."
    redirect_to announcements_path
  end

  def create
     if(@current_user.admin == 1)
      redirect_to announcements_path
     end
    @announcement = Announcement.create!(announcement_params)
    flash[:notice] = "'#{@announcement.title}' was successfully created."
    redirect_to announcements_path
  end
  
  def destroy
    if(@current_user.admin == 1)
      redirect_to announcements_path
    end
    @announcement = Announcement.find(params[:id])
    @announcement.destroy
    flash[:notice] = "'#{@announcement.title}' was successfully deleted."
    redirect_to announcements_path
  end
end
