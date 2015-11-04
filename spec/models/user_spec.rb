require 'spec_helper'
require 'rails_helper'

RSpec.describe User, type: :model do
    describe "authenticating a user" do
       context "with an email that exists in the database" do
           context "with the correct password" do
               it "should call find_by_email" do
                    fake_result = double("user")
                    allow(fake_result).to receive(:password_hash) {"1"}
                    allow(fake_result).to receive(:password_salt) {"$2a$10$IOTTDmZi0yU.VE19cK9Fle"}
                    expect(User).to receive(:find_by_email).with('email').and_return(fake_result)
                    User.authenticate("email", "password")	
               end
               it "should call the bcrypt hash method" do
                    fake_result = double("user")
                    allow(fake_result).to receive(:password_hash) {"1"}
                    allow(fake_result).to receive(:password_salt) {"$2a$10$IOTTDmZi0yU.VE19cK9Fle"}
                    expect(User).to receive(:find_by_email).with('email').and_return(fake_result)
                    fake_hash = double("hash")
                    expect(BCrypt::Engine).to receive(:hash_secret).with("password", "$2a$10$IOTTDmZi0yU.VE19cK9Fle").and_return(fake_hash)
                    User.authenticate("email", "password")
               end
               it "should return the user" do
                    fake_result = double("user")
                    allow(fake_result).to receive(:password_hash) {"1"}
                    allow(fake_result).to receive(:password_salt) {"$2a$10$IOTTDmZi0yU.VE19cK9Fle"}
                    expect(User).to receive(:find_by_email).with('email').and_return(fake_result)
                    fake_hash = "1"
                    expect(BCrypt::Engine).to receive(:hash_secret).with("password", "$2a$10$IOTTDmZi0yU.VE19cK9Fle").and_return(fake_hash)
                    expect(User.authenticate("email", "password")).to eq(fake_result)
               end
           end
           context "with the incorrect password" do
               it "should call find_by_email" do
                    fake_result = double("user")
                    allow(fake_result).to receive(:password_hash) {"1"}
                    allow(fake_result).to receive(:password_salt) {"$2a$10$IOTTDmZi0yU.VE19cK9Fle"}
                    expect(User).to receive(:find_by_email).with('email').and_return(fake_result)
                    User.authenticate("email", "password")	
               end
               it "should call the bcrypt hash method" do
                    fake_result = double("user")
                    allow(fake_result).to receive(:password_hash) {"1"}
                    allow(fake_result).to receive(:password_salt) {"$2a$10$IOTTDmZi0yU.VE19cK9Fle"}
                    expect(User).to receive(:find_by_email).with('email').and_return(fake_result)
                    fake_hash = double("hash")
                    expect(BCrypt::Engine).to receive(:hash_secret).with("password", "$2a$10$IOTTDmZi0yU.VE19cK9Fle").and_return(fake_hash)
                    User.authenticate("email", "password")
               end
               it "should return nil" do
                    fake_result = double("user")
                    allow(fake_result).to receive(:password_hash) {"1"}
                    allow(fake_result).to receive(:password_salt) {"$2a$10$IOTTDmZi0yU.VE19cK9Fle"}
                    expect(User).to receive(:find_by_email).with('email').and_return(fake_result)
                    fake_hash = "2"
                    expect(BCrypt::Engine).to receive(:hash_secret).with("password", "$2a$10$IOTTDmZi0yU.VE19cK9Fle").and_return(fake_hash)
                    expect(User.authenticate("email", "password")).to eq(nil)
               end
           end
       end
       context "with an email that doesn't exist in the database" do
            it "should call find_by_email" do
                expect(User).to receive(:find_by_email).with('email').and_return(nil)
                User.authenticate("email", "password")	
            end
            it "should return nil" do
                expect(User).to receive(:find_by_email).with('email').and_return(nil)
                expect(User.authenticate("email", "password")).to eq(nil)
            end
       end
    end
    
    describe "encrypting password and setting a session token" do
        context "with a password" do
            it "should call BCrypt and SecureRandom methods and assign instance variables" do
                fake_salt = "$2a$10$IOTTDmZi0yU.VE19cK9Fle"
                fake_hash = "1"
                fake_token = "2"
                expect(BCrypt::Engine).to receive(:generate_salt).and_return(fake_salt)
                expect(BCrypt::Engine).to receive(:hash_secret).with("password", fake_salt).and_return(fake_hash)
                expect(SecureRandom).to receive(:base64).and_return(fake_token)
                u = User.new(:name => "name", :email => "email", :password => "password")
                u.encrypt_password
                expect(u.password_salt).to eq(fake_salt)
                expect(u.password_hash).to eq(fake_hash)
                expect(u.session_token).to eq(fake_token)
            end
        end
    end
end