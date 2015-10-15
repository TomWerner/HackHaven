class AnnouncementsController < ApplicationController
  def announcement_params
    params.require(:announcement).permit(:title, :content)
  end
  
  def show
  end

  def index
    @announcements = Announcement.all
  end

  def edit
  end

  def new
  end

  def create
    @announcement = Announcement.create!(announcement_params)
    flash[:notice] = "#{@announcement.title} was successfully created."
    redirect_to announcements_path
  end
end
