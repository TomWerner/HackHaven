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
    if @admin != 0
      redirect_to(announcements_path) and return
    end
    @announcement = Announcement.find params[:id]
  end

  def new
    if @admin != 0
      redirect_to(announcements_path) and return
    end
    #just displays the new template
  end
  
  def update
    if @admin != 0
      redirect_to(announcements_path) and return
    end
    @announcement = Announcement.find params[:id]
    @announcement.update_attributes!(announcement_params)
    flash[:notice] = "'#{@announcement.title}' was successfully updated."
    redirect_to announcements_path
  end

  def create
    if @admin != 0
      redirect_to(announcements_path) and return
    end
    @announcement = Announcement.new(announcement_params)
    if @announcement.save
      flash[:notice] = "'#{@announcement.title}' was successfully created."
      redirect_to announcements_path
    else
      render 'new'
    end
  end
  
  def destroy
    if @admin != 0
      redirect_to(announcements_path) and return
    end
    @announcement = Announcement.find(params[:id])
    @announcement.destroy
    flash[:notice] = "'#{@announcement.title}' was successfully deleted."
    redirect_to announcements_path
  end
end
