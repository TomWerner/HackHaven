require 'spec_helper'
require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
    
    describe "creating a new session" do
       context "with valid credentials" do
           it "should call the model method for user authentications" do
               fake_result = double('user1')
               allow(fake_result).to receive(:session_token) {'10d'}
               expect(User).to receive(:authenticate).with('Email', 'Password').and_return (fake_result)
               post :create, {:user => {:email => 'Email', :password => 'Password'}}
           end
           it "should redirect to announcements" do
               fake_result = double('user1')
               allow(fake_result).to receive(:session_token) {'10d'}
               expect(User).to receive(:authenticate).with('Email', 'Password').and_return (fake_result)
               post :create, {:user => {:email => 'Email', :password => 'Password'}}
               expect(response).to redirect_to('/announcements')
           end
           it "should set the session cooke to the session token of the user" do
               fake_result = double('user1')
               allow(fake_result).to receive(:session_token) {'10d'}
               expect(User).to receive(:authenticate).with('Email', 'Password').and_return (fake_result)
               post :create, {:user => {:email => 'Email', :password => 'Password'}}
               expect(session[:session_token]).to eq "10d"
           end
       end
       context "with in-valid credentials" do
           it "should call the model method for user authentications" do
               fake_result = nil
               expect(User).to receive(:authenticate).with('Email', 'Password').and_return (fake_result)
               post :create, {:user => {:email => 'Email', :password => 'Password'}}
           end
           it "should redirect to login" do
               fake_result = nil
               expect(User).to receive(:authenticate).with('Email', 'Password').and_return (fake_result)
               post :create, {:user => {:email => 'Email', :password => 'Password'}}
               expect(response).to redirect_to(login_path)
           end
       end
    end
    
    describe "destroying a session" do
        it "should set the session cooke to nil" do
            post :destroy
            expect(session[:session_token]).to eq nil
        end
        it "should redirect to announcements" do
            post :destroy
            expect(response).to redirect_to('/announcements')
        end
    end
end