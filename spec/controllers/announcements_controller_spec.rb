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
  
  describe 'GET #edit' do
    it 'assigns the @announcement variable' do
      fake_result = double('announcement')
      expect(Announcement).to receive(:find).with('1').and_return(fake_result)
      get :edit, id: 1
      expect(assigns(:announcement)).to eq(fake_result)
    end
  end
  
  describe '#update' do
    it 'assigns updates @announcement variable' do
      update = {announcement: {title: "New title", content: "New content"}}
      announcement = Announcement.create(title: "Title", content: "Content")
      expect(Announcement).to receive(:find).with("1").and_return(announcement)
      expect(announcement).to receive(:update_attributes!).with(update[:announcement])
      expect(announcement).to receive(:title).and_return("New title")
      update[:id] = 1
      post :update, update
      expect(flash[:notice]).to eq("'New title' was successfully updated.")
      expect(response).to redirect_to(announcements_path)
    end
  end
  
  describe '#create' do
    it 'creates the announcement' do
      create_params = {announcement: {title: "Title", content: "Content"}}
      announcement = Announcement.create(title: "Title", content: "Content")
      expect(Announcement).to receive(:create!).with(create_params[:announcement]).and_return(announcement)
      expect(announcement).to receive(:title).and_return("Title")
      post :create, create_params
      expect(flash[:notice]).to eq("'Title' was successfully created.")
      expect(response).to redirect_to(announcements_path)
    end
  end
  
  describe '#destroy' do
    it 'destroys the announcement' do
      destroy_params = {id: 1, announcement: {title: "Title", content: "Content"}}
      announcement = Announcement.create(title: "Title", content: "Content")
      expect(Announcement).to receive(:find).with("1").and_return(announcement)
      expect(announcement).to receive(:destroy)
      expect(announcement).to receive(:title).and_return("Title")
      post :destroy, destroy_params
      expect(flash[:notice]).to eq("'Title' was successfully deleted.")
      expect(response).to redirect_to(announcements_path)
    end
  end
end
