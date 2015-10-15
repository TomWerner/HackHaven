class AnnouncementsController < ApplicationController
  def announcement_params
    params.require(:announcement).permit(:title, :content)
  end

  def index
    @announcements = Announcement.all
  end

  def edit
    @announcement = Announcement.find params[:id]
  end

  def new
    #just displays the new template
  end
  
  def update
    @announcement = Announcement.find params[:id]
    @announcement.update_attributes!(announcement_params)
    flash[:notice] = "#{@announcement.title} was successfully updated."
    redirect_to announcements_path
  end

  def create
    @announcement = Announcement.create!(announcement_params)
    flash[:notice] = "#{@announcement.title} was successfully created."
    redirect_to announcements_path
  end
end
