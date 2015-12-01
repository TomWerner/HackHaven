require 'spec_helper'
require 'rails_helper'
require 'active_support'
require 'active_support/core_ext'

RSpec.describe TeamsController, type: :controller do
    describe 'index page' do
        it 'should render the index template' do
            get :index
            expect(response).to render_template('index')
        end
        it 'should display no teams because no teams in db' do
            expect(assigns(:teams)).to eq nil
            get :index
        end
        it 'should display Teams in order' do
            @fake_team = Team.create!(:name => "fake", :contestname => "Fake", :captain => "3")
            @fake_team2 = Team.create!(:name => "fake2", :contestname => "Fake", :captain => "3")
            @fake_teams = [@fake_team, @fake_team2]
            expect(Team).to receive(:order).and_return(@fake_teams)
            get :index
        end
    end
    describe 'leaderboard' do
        it 'should render the index template' do
            get :leaderboard, id: 1, contestname: 'Fighting in Fortran'
            expect(response).to render_template('leaderboard')
        end
        it 'should display no teams because no teams in db' do
            expect(assigns(:teams)).to eq nil
            get :leaderboard, id: 1, contestname: 'Matlab Mayhem'
        end
        it 'should display Teams in order of points' do
            @fake_team = Team.create!(:name => "fake", :contestname => "Matlab Mayhem", :captain => "3", :points => 3)
            @fake_team2 = Team.create!(:name => "fake2", :contestname => "Matlab Mayhem", :captain => "3", :points => 2)
            @fake_teams = [@fake_team, @fake_team2]
            expect(Team).to receive_message_chain(:where, :order).and_return(@fake_teams)
            #expect(@fake_teams).to receive(:order)
            get :leaderboard, id: 1, contestname: 'Matlab Mayhem'
        end
    end
    describe 'show' do
        before :each do
            @fake_team = Team.create!(:id => "3", :name => "fake", :contestname => "Fake", :captain => "3")
            @fake_result1 = Registration.create!(:id => "3", :userid => "3", :firstname => "Fake", :lastname => "fake", :email => "fake_email", :year => "fake", :major => "fake", :contestname => "contest1", :team => "fake")
            @user = User.create!(:id => "3", :email => "email", :password => "password")
            @fake_result2 = Registration.create!(:id => "4", :userid => "4", :firstname => "Fake", :lastname => "fake", :email => "fake_email", :year => "fake", :major => "fake", :contestname => "contest1", :team => "fake")
            @user2 = User.create!(:id => "4", :email => "email2", :password => "passsss")
            @fake_results = [@fake_result1, @fake_result2]
            #@user = User.create!(:)
        end
        it 'should call team method to find by id' do
            expect(Team).to receive(:find).with("3").and_return(@fake_team)
            get :show, id: 3
        end
        it 'should find two regs when there are two' do
            allow(Team).to receive(:find).and_return(@fake_team)
            expect(Registration).to receive(:where).and_return(@fake_results)
            get :show, id: 3
        end
    end
    describe 'destroy team' do
        before :each do
            @fake_team2 = Team.create!(:name => "SUPER", :contestname => "Fake", :captain => "101")
            @fake_result1 = Registration.create!(:userid => "101", :firstname => "Fake", :lastname => "fake", :email => "fake_email", :year => "fake", :major => "fake", :contestname => "Fake", :team => "SUPER")
            @fake_results = [@fake_result1]
        end
        it 'should call Registration method to find registrations with Team' do
            allow(Team).to receive(:find).with("101").and_return(@fake_team2)
            expect(Registration).to receive(:where).with({:team => @fake_team2.name}).and_return(@fake_results)
            expect(Registration).to receive(:where).with({:userid => 101}).and_return(@fake_results)
            delete :destroy, id: 101
        end
        it 'should call destroy' do
            allow(Team).to receive(:find).with("101").and_return(@fake_team2)
            allow(Registration).to receive(:where).with({:team => @fake_team2.name}).and_return(@fake_results)
            allow(Registration).to receive(:where).with({:userid => 101}).and_return(@fake_results)
            expect(@fake_team2).to receive(:destroy)
            delete :destroy, id: 101
        end
    end
    describe 'remove' do
        before :each do
             @fake_reg = Registration.create!(:userid => "10", :firstname => "Fake", :lastname => "fake", :email => "fake_email", :year => "fake", :major => "fake", :contestname => "Fake", :team => "MOSFETS")
        end
        it 'should find user by id' do
            expect(Registration).to receive(:find_by_userid).with("10").and_return(@fake_reg)
            get :remove, id: 10
        end
        it 'should call Registration method save! after changing team name' do
            allow(Registration).to receive(:find_by_userid).with("10").and_return(@fake_reg)
            expect(@fake_reg).to receive(:save!)
            get :remove, id: 10
        end
    end
    describe 'captainize' do
        before :each do
            @faketeam = Team.create!(:name => "RAD", :contestname => "RAD", :captain => "11")
        end
        it 'should find Team by team id' do
            expect(Team).to receive(:find).and_return(@faketeam)
            get :captainize, id: 11, teamid: 12
        end
        it 'should call save after changing captain' do
            allow(Team).to receive(:find).and_return(@faketeam)
            expect(@faketeam).to receive(:save!)
            get :captainize, id: 11, teamid: 12
        end
    end
end
