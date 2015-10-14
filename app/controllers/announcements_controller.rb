class AnnouncementsController < ApplicationController
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
  end
end
