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
    context "as an admin" do
      it 'assigns the @announcement variable' do
        user = User.new(:name => "Kaitlyn", :email => "Kaitlyn@aol.com", :admin => 0, :password => "passCode")
        user.save
        session[:session_token] = user.session_token
        fake_result = double('announcement')
        expect(Announcement).to receive(:find).with('1').and_return(fake_result)
        get :edit, id: 1
        expect(assigns(:announcement)).to eq(fake_result)
      end
    end
    context "as a regular member" do 
      it 'attempts to assign the @announcement variable as a non-admin user' do
        user = User.new(:name => "Kaitlyn", :email => "Kaitlyn@aol.com", :admin => 1, :password => "passCode")
        user.save
        session[:session_token] = user.session_token
        get :edit, id: 1
        expect(response).to redirect_to('/announcements')
      end
    end
    context "when not logged in" do 
      it 'attempts to assign the @announcement variable as a non-admin, non-user' do
        session[:session_token] = nil
        get :edit, id: 1
        expect(response).to redirect_to('/announcements')
      end      
    end
  end
  
  describe 'GET #new' do
    context "as a regular member" do 
      it 'attempts to assign the @announcement variable as a non-admin user' do
        user = User.new(:name => "Kaitlyn", :email => "Kaitlyn@aol.com", :admin => 1, :password => "passCode")
        user.save
        session[:session_token] = user.session_token
        fake_result = double('announcement')

        get :new
        expect(response).to redirect_to('/announcements')
      end
    end
    context "when not logged in" do 
      it 'attempts to assign the @announcement variable as a non-admin, non-user' do
        session[:session_token] = nil
        fake_result = double('announcement')
        get :new
        expect(response).to redirect_to('/announcements')
      end      
    end
  end
  
  describe '#update' do
    context "as an admin" do
      it 'assigns updates @announcement variable' do
        user = User.new(:name => "Kaitlyn", :email => "Kaitlyn@aol.com", :admin => 0, :password => "passCode")
        user.save
        session[:session_token] = user.session_token
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
    context "as a non-admin user" do
       it 'tries to assign updates @announcement variable' do
        user = User.new(:name => "Kaitlyn", :email => "Kaitlyn@aol.com", :admin => 1, :password => "passCode")
        user.save
        session[:session_token] = user.session_token
        update = {announcement: {title: "New title", content: "New content"}}
        announcement = Announcement.create(title: "Title", content: "Content")
        update[:id] = 1
        post :update, update
        expect(flash[:notice]).to eq(nil)
        expect(response).to redirect_to(announcements_path)
      end
    end
    context "as a non-admin and a non-user" do
       it 'treis to assign updates @announcement variable' do
        session[:session_token] = nil
        update = {announcement: {title: "New title", content: "New content"}}
        announcement = Announcement.create(title: "Title", content: "Content")
        update[:id] = 1
        post :update, update
        expect(flash[:notice]).to eq(nil)
       expect(response).to redirect_to(announcements_path)
      end
    end
  end
  
  describe '#create' do
    context 'as an admin' do
      it 'creates the announcement' do
        user = User.new(:name => "Kaitlyn", :email => "Kaitlyn@aol.com", :admin => 0, :password => "passCode")
        user.save
        session[:session_token] = user.session_token
        create_params = {announcement: {title: "Title", content: "Content"}}
        announcement = Announcement.create(title: "Title", content: "Content")
        expect(Announcement).to receive(:new).with(create_params[:announcement]).and_return(announcement)
        expect(announcement).to receive(:save).and_return(announcement)
        expect(announcement).to receive(:title).and_return("Title")
        post :create, create_params
        expect(flash[:notice]).to eq("'Title' was successfully created.")
        expect(response).to redirect_to(announcements_path)
      end
    end
    context 'as a non-admin member' do
      it 'try to create the announcement' do
        user = User.new(:name => "Kaitlyn", :email => "Kaitlyn@aol.com", :admin => 1, :password => "passCode")
        user.save
        session[:session_token] = user.session_token
        create_params = {announcement: {title: "Title", content: "Content"}}
        announcement = Announcement.create(title: "Title", content: "Content")
        post :create, create_params
        expect(flash[:notice]).to eq(nil)
        expect(response).to redirect_to(announcements_path)
      end      
    end
    context 'as a non-admin member' do
      it 'try to create the announcement' do
        session[:session_token] = nil
        create_params = {announcement: {title: "Title", content: "Content"}}
        announcement = Announcement.create(title: "Title", content: "Content")
        post :create, create_params
        expect(flash[:notice]).to eq(nil)
        expect(response).to redirect_to(announcements_path)
      end   
    end
  end
  
  describe '#destroy' do
    context 'as an admin' do 
      it 'destroys the announcement ' do
        user = User.new(:name => "Kaitlyn", :email => "Kaitlyn@aol.com", :admin => 0, :password => "passCode")
        user.save
        session[:session_token] = user.session_token
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
    context 'as a non-admin member' do
      it 'tires to destroy the announcement ' do
        user = User.new(:name => "Kaitlyn", :email => "Kaitlyn@aol.com", :admin => 1, :password => "passCode")
        user.save
        session[:session_token] = user.session_token
        destroy_params = {id: 1, announcement: {title: "Title", content: "Content"}}
        announcement = Announcement.create(title: "Title", content: "Content")

        post :destroy, destroy_params
        expect(flash[:notice]).to eq(nil)
        expect(response).to redirect_to(announcements_path)
      end
    end
    context 'as a non-admin and non-member user' do
      it 'tires to destroy the announcement ' do

        session[:session_token] = nil
        destroy_params = {id: 1, announcement: {title: "Title", content: "Content"}}
        announcement = Announcement.create(title: "Title", content: "Content")

        post :destroy, destroy_params
        expect(flash[:notice]).to eq(nil)
        expect(response).to redirect_to(announcements_path)
      end
    end
  end
end
