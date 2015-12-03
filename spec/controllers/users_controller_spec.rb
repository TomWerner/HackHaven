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
               allow(fake_result).to receive(:confirmation_code) {123}
               allow(fake_result).to receive(:confirmed) {false}
               expect(SecureRandom).to receive(:base64).and_return(123)
               fake_mailer = double('mailer')
               expect(UserMailer).to receive(:email_confirmation).with(fake_result).and_return(fake_mailer)
               expect(fake_mailer).to receive(:deliver_later)
               expect(User).to receive(:new).with(:name => "name", :email => "email", :password => "password", :admin => 1, confirmation_code: 123, confirmed: false).and_return (fake_result)
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
               allow(fake_result).to receive(:confirmation_code) {123}
               allow(fake_result).to receive(:confirmed) {false}
               expect(SecureRandom).to receive(:base64).and_return(123)
               fake_mailer = double('mailer')
               expect(UserMailer).to receive(:email_confirmation).with(fake_result).and_return(fake_mailer)
               expect(fake_mailer).to receive(:deliver_later)
               expect(User).to receive(:new).with(:name => "name", :email => "email", :password => "password", :admin =>1, confirmation_code: 123, confirmed: false).and_return (fake_result)
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
               allow(fake_result).to receive(:confirmation_code) {123}
               allow(fake_result).to receive(:confirmed) {false}
               expect(SecureRandom).to receive(:base64).and_return(123)
               expect(User).to receive(:new).with(:name => "name", :email => "email", :password => "password", :admin => 1, confirmation_code: 123, confirmed: false).and_return (fake_result)
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
               allow(fake_result).to receive(:confirmation_code) {123}
               allow(fake_result).to receive(:confirmed) {false}
               expect(SecureRandom).to receive(:base64).and_return(123)
               expect(User).to receive(:new).with(:name => "name", :email => "email", :password => "password", :admin => 1, confirmation_code: 123, confirmed: false).and_return (fake_result)
               post :create, {:user => {:name => 'name', :email => 'email', :password => 'password', :admin => 1}}
               expect(response).to redirect_to(new_user_path)
           end
        end
    end
    
    describe "post #update" do
        context "the user is an admin" do
          it "should allow the user to change the role of another user" do
            update = {user: {admin: "0"}}
            update[:id] = 1
            example = User.new(:name => "example", :email => "Example@example.com", :admin => 1, :password => "password")
            example.save
            user = User.new(:name => "Kaitlyn", :email => "Kaitlyn@aol.com", :admin => 0, :password => "passCode")
            user.save
            session[:session_token] = user.session_token
            post :update, update
            expect(flash[:notice]).to eq("'example' was successfully updated.")
            expect(response).to redirect_to(users_path)
          end
        end
        context "the user is a member" do 
            it "should allow the user to try to visit the user index, but be redirected" do
              update = {user: {admin: "1"}}
              update[:id] = 1
              user = User.new(:name => "Kaitlyn", :email => "Kaitlyn@aol.com", :admin => 1, :password => "passCode")
              user.save
              session[:session_token] = user.session_token
              post :update, update
              expect(flash[:notice]).to eq(nil)
              expect(response).to redirect_to(announcements_path)
            end
        end
        context "the user is not logged in" do
          it "should allow the user to try to visit the user index, but be redirected" do
            update = {user: {admin: "1"}}
            update[:id] = 1
            session[:session_token] = nil
            post :update, update
            expect(flash[:notice]).to eq(nil)
            expect(response).to redirect_to(announcements_path)
          end
        end
    end
    describe 'GET #edit' do
      context "the user is an admin" do
          it "when the admin tries to visit the edit page, they are successful" do
            user = User.new(:name => "Kaitlyn", :email => "Kaitlyn@aol.com", :admin => 0, :password => "passCode")
            user.save
            session[:session_token] = user.session_token
            get :edit, id: 1
            expect(response).to have_http_status(:success)
          end
          it "when the admin visits the eidt page, they get the correct response" do
            user = User.new(:name => "Kaitlyn", :email => "Kaitlyn@aol.com", :admin => 0, :password => "passCode")
            user.save
            session[:session_token] = user.session_token
            val = get :edit, id: 1
             expect(assigns(:user)).to eq(user)
          end
      end
      context "the user is a member" do
        it "when the user tries to visit the edit page, they are redirected to the announcements_path" do
          user = User.new(:name => "Kaitlyn", :email => "Kaitlyn@aol.com", :admin => 1, :password => "passCode")
          user.save
          session[:session_token] = user.session_token
          get :edit, id: 1
          expect(response).to redirect_to(announcements_path)
        end
      end
      context "the user is not logged in" do
        it "when the user tries to visit the edit page, they are redirected to the announcements_path" do
          user = User.new(:name => "Kaitlyn", :email => "Kaitlyn@aol.com", :admin => 1, :password => "passCode")
          user.save
          get :edit, id: 1
          expect(response).to redirect_to(announcements_path)
        end
      end
    end
    describe "GET #index" do
      context "the user is an admin" do
          it "then it will display a list of users" do
            user = User.new(:name => "Kaitlyn", :email => "Kaitlyn@aol.com", :admin => 0, :password => "passCode")
            user.save
            session[:session_token] = user.session_token
            get :index
            expect(response).to have_http_status(:success)
          end
      end
      context "the user is a member" do 
          it "then it will not display users, but will redirect to the announcements_path" do 
            user = User.new(:name => "Kaitlyn", :email => "Kaitlyn@aol.com", :admin => 1, :password => "passCode")
            user.save
            session[:session_token] = user.session_token
            get :index
            expect(response).to redirect_to(announcements_path)
          end
      end
      context "the user is not logged in" do
        it "then it will not display users, but will redirect to the announcements_path" do 
            user = User.new(:name => "Kaitlyn", :email => "Kaitlyn@aol.com", :admin => 1, :password => "passCode")
            user.save
            session[:session_token] = nil
            get :index
            expect(response).to redirect_to(announcements_path)
        end
      end
        
    end
    
    describe 'GET #confirm' do
        it 'should make sure we have the right user (fail if not current)' do
            confirm_params = {:user_id => "123", :code => "abcd"}
            session[:session_token] = 123
            current_user = User.new(name: "Tom")
            expect(User).to receive(:find_by_session_token).and_return(current_user)
      
            user = double('user')
            allow(user).to receive(:id) {1}
            expect(User).to receive(:find).with("123").and_return(user)
            get :confirm, confirm_params
            
            expect(flash[:notice]).to eq("Invalid user id")
            expect(response).to redirect_to('/')
        end
        it 'should make sure we have the right user (fail if invalid)' do
            confirm_params = {:user_id => "123", :code => "abcd"}
            session[:session_token] = 123
            current_user = User.new(name: "Tom")
            expect(User).to receive(:find_by_session_token).and_return(current_user)
      
            user = double('user')
            allow(user).to receive(:id) {1}
            expect(User).to receive(:find).with("123").and_return(nil)
            get :confirm, confirm_params
            
            expect(flash[:notice]).to eq("Invalid user id")
            expect(response).to redirect_to('/')
        end
        it 'should notify us if the code is invalid' do
            confirm_params = {:user_id => "123", :code => "abcd"}
            session[:session_token] = 123
      
            user = double('user')
            expect(User).to receive(:find_by_session_token).and_return(user)
            allow(user).to receive(:id) {1}
            allow(user).to receive(:confirmation_code) {"abcde"}
            allow(user).to receive(:confirmed) {false}
            allow(user).to receive(:name) {"Tom"}
            allow(user).to receive(:admin) {1}
            expect(User).to receive(:find).with("123").and_return(user)
            get :confirm, confirm_params
            
            expect(flash[:notice]).to eq("Email confirmation unsuccessful...")
            expect(response).to redirect_to('/')
        end
        it 'should work if the code is correct' do
            confirm_params = {:user_id => "123", :code => "abcd"}
            session[:session_token] = 123
      
            user = double('user')
            expect(User).to receive(:find_by_session_token).and_return(user)
            allow(user).to receive(:id) {1}
            allow(user).to receive(:confirmation_code) {"abcd"}
            allow(user).to receive(:confirmation_code=)
            allow(user).to receive(:confirmed) {false}
            allow(user).to receive(:confirmed=)
            allow(user).to receive(:name) {"Tom"}
            allow(user).to receive(:admin) {1}
            expect(user).to receive(:confirmed=).with(true)
            expect(user).to receive(:save)
            expect(User).to receive(:find).with("123").and_return(user)
            get :confirm, confirm_params
            
            expect(flash[:notice]).to eq("Email confirmed!")
            expect(response).to redirect_to('/')
        end
    end
end