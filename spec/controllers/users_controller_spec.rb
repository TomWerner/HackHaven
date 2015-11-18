require 'spec_helper'
require 'rails_helper'

RSpec.describe UsersController, type: :controller do
    
    describe "creating a new user" do
        context "with an email that doesn't already exist in the database" do
            it "should call the model method to create a new user" do
               fake_result = double('user')
               allow(fake_result).to receive(:save) {true}
               allow(fake_result).to receive(:name) {"name"}
               allow(fake_result).to receive(:email) {"email"}
               allow(fake_result).to receive(:password) {"password"}
               allow(fake_result).to receive(:session_token) {"session_token"}
               allow(fake_result).to receive(:admin) {1}
               expect(User).to receive(:new).with(:name => "name", :email => "email", :password => "password", :admin => 1).and_return (fake_result)
               post :create, {:user => {:name => 'name', :email => 'email', :password => 'password', ":admin" => 1}}
           end
           it "should redirect to announcements" do
               fake_result = double('user')
               allow(fake_result).to receive(:save) {true}
               allow(fake_result).to receive(:name) {"name"}
               allow(fake_result).to receive(:email) {"email"}
               allow(fake_result).to receive(:password) {"password"}
               allow(fake_result).to receive(:session_token) {"session_token"}
               allow(fake_result).to receive(:admin) {1}
               expect(User).to receive(:new).with(:name => "name", :email => "email", :password => "password", :admin =>1).and_return (fake_result)
               post :create, {:user => {:name => 'name', :email => 'email', :password => 'password', :admin => 1}}
               expect(response).to redirect_to('/announcements')
           end
        end
        context "with an email that already exists in the database" do
            it "should call the model method to create a new user" do
               fake_result = double('user')
               allow(fake_result).to receive(:save) {false}
               allow(fake_result).to receive(:name) {"name"}
               allow(fake_result).to receive(:email) {"email"}
               allow(fake_result).to receive(:password) {"password"}
               allow(fake_result).to receive(:session_token) {"session_token"}
               allow(fake_result).to receive(:admin) {1}
               expect(User).to receive(:new).with(:name => "name", :email => "email", :password => "password", :admin => 1).and_return (fake_result)
               post :create, {:user => {:name => 'name', :email => 'email', :password => 'password', :admin =>1 }}
           end
           it "should redirect to login" do
               fake_result = double('user')
               allow(fake_result).to receive(:save) {false}
               allow(fake_result).to receive(:name) {"name"}
               allow(fake_result).to receive(:email) {"email"}
               allow(fake_result).to receive(:password) {"password"}
               allow(fake_result).to receive(:session_token) {"session_token"}
               allow(fake_result).to receive(:admin) {1}
               expect(User).to receive(:new).with(:name => "name", :email => "email", :password => "password", :admin => 1).and_return (fake_result)
               post :create, {:user => {:name => 'name', :email => 'email', :password => 'password', :admin => 1}}
               expect(response).to redirect_to(new_user_path)
           end
        end
    end
    
    
end