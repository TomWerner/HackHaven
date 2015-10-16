require 'spec_helper'
require 'rails_helper'

RSpec.describe AnnouncementsController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
    
    it "returns the announcements, newest first" do
      Announcement.create!(title:"First announcement", content:"My content")
      Announcement.create!(title:"Second announcement", content:"Other content")
      announcements = AnnouncementsController.new.index
      
      expect(announcements.size).to equal(2)
      expect(announcements[0].title).to eq("Second announcement")
      expect(announcements[1].title).to eq("First announcement")
    end
  end

end
