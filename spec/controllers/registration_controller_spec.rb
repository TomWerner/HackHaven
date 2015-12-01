require 'spec_helper'
require 'rails_helper'
require 'active_support'
require 'active_support/core_ext'

describe RegistrationController, type: :controller do
    describe 'index page' do
        it 'should render the index template' do
            get :index
            expect(response).to render_template('index')
        end
        it 'should display no registrations because no user logged in' do
            expect(assigns(:registrations)).to eq nil
            get :index
        end
    end
    describe 'edit' do
        before :each do
            @fake_result = Registration.create!(:id => "3", :firstname => "Fake", :userid => "3", :lastname => "fake", :email => "fake_email", :year => "fake", :major => "fake", :contestname => "contest1", :team => "fake")
            @fake_contest = Contest.create!(:contestname => "Fake", :contestdate => 2011-11-11)
            @fake_team = Team.create!(:name => "fake", :contestname => "Fake", :captain => "3")
            @fake_team_array = []
            @fake_team_array.push @fake_team
            @empty_array = []
            allow(@fake_result).to receive(:contestname).and_return("Fake")
            allow(Contest).to receive(:find_by_contestname).and_return(@fake_contest)
            allow(@fake_contest).to receive(:contestname).and_return("Fake")
        end
        it 'should call model method to find registration based on id' do
            expect(Registration).to receive(:find).with('3').and_return(@fake_result)
            allow(Team).to receive(:where).and_return(@empty_array)
            get :edit, id: 3
        end
        it 'should assign registration found by reg id to registration variable' do
           allow(Registration).to receive(:find).with('3').and_return(@fake_result)
           allow(Team).to receive(:where).and_return(@fake_team_array)
           #allow(@fake_team).to receive(:first).and_return(@fake_team)
            
           get :edit, id: 3
           expect(assigns(:registration)).to eq @fake_result 
        end
    end
    describe 'new' do
        before :each do
            @fake_contest = Contest.create!(:contestname => "Fake", :contestdate => 2011-11-11)
            allow(Contest).to receive(:find).with('3').and_return(@fake_contest)
        end
        it 'should render the new template' do
            get :new, id: 3
            expect(response).to render_template('new')
        end
        it 'should assign nil to currentuserid because no user logged in' do
            expect(assigns(:currentuserid)).to eq nil
            get :new, id: 3
        end
    end
    describe 'update' do
        before :each do
            #@fake_result = Registration.create!(:id => "3", :firstname => "Fake", :lastname => "fake", :email => "fake_email", :year => "fake", :major => "fake", :contestname => "contest1", :team => "fake")
            @fake_contest = Contest.create!(:contestname => "Fake", :contestdate => 2011-11-11)
            #allow(@fake_result).to receive(:contestname).and_return("Fake")
            allow(Contest).to receive(:find_by_contestname).and_return(@fake_contest)
            allow(@fake_contest).to receive(:contestname).and_return("Fake")
        end
        it 'should update firstname attribute' do
            @fake_result = Registration.create!(:id => "3", :firstname => "Fake", :lastname => "fake", :email => "fake_email", :year => "fake", :major => "fake", :contestname => "contest1", :team => "fake")
            expect(Registration).to receive(:find).with('3').and_return(@fake_result)
            parameters = {:id => '3', :registration => {:id => 3, :firstname => "new name", :lastname => "fake", :email => "fake_email", :year => "fake", :major => "fake", :contestname => "contest1", :team => "fake"}}
            
            expect(@fake_result).to receive(:update_attributes).with({"firstname" => "new name", "lastname" => "fake", "email" => "fake_email", "year" => "fake", "major" => "fake", "contestname" => "contest1", "team" => "fake"})
            post :update, parameters
        end
        it 'should redirect to edit' do
            @fake_result = Registration.create!(:id => "3", :firstname => "Fake", :lastname => "fake", :email => "fake_email", :year => "fake", :major => "fake", :contestname => "contest1", :team => "fake")
            allow(Registration).to receive(:find).with('3').and_return(@fake_result)
            parameters = {:id => '3', :registration => {:id => 3, :firstname => "new name", :lastname => "fake", :email => "fake_email", :year => "fake", :major => "fake", :contestname => "contest1", :team => "fake"}}
            allow(@fake_result).to receive(:update_attributes).with({"firstname" => "new name", "lastname" => "fake", "email" => "fake_email", "year" => "fake", "major" => "fake", "contestname" => "contest1", "team" => "fake"})
            post :update, parameters
            expect(response).to render_template('registration/edit')
        end
        it 'should save!' do
            @fake_result = Registration.create!(:userid => "3", :firstname => "Fake", :lastname => "fake", :email => "fake_email", :year => "fake", :major => "fake", :contestname => "contest1", :team => "fake", :id => "3")
            allow(Registration).to receive(:find).with('3').and_return(@fake_result)
            parameters = {:id => '3', :registration => {:userid => "3", :firstname => "new name", :lastname => "fake", :email => "fake_email", :year => "fake", :major => "fake", :contestname => "contest1", :team => "Selected", :selectedteam => "fake", :newteam => "Nope"}}
            allow(@fake_result).to receive(:update_attributes).with({"userid" => "3", "firstname" => "new name", "lastname" => "fake", "email" => "fake_email", "year" => "fake", "major" => "fake", "contestname" => "contest1", "team" => "fake", "selectedteam" => "fake", "newteam" => "Nope"}).and_return(true)
            expect(@fake_result).to receive(:save!)
            post :update, parameters
            expect(response).to redirect_to('/registration')
        end
        it 'should create new team!' do
            @fake_result = Registration.create!(:userid => "3", :firstname => "Fake", :lastname => "fake", :email => "fake_email", :year => "fake", :major => "fake", :contestname => "contest1", :team => "awesome", :id => "3")
            allow(Registration).to receive(:find).with('3').and_return(@fake_result)
            parameters = {:id => '3', :registration => {:userid => "3", :firstname => "new name", :lastname => "fake", :email => "fake_email", :year => "fake", :major => "fake", :contestname => "contest1", :team => "Create Own Team", :selectedteam => "fake", :newteam => "awesome"}}
            allow(@fake_result).to receive(:update_attributes).with({"userid" => "3", "firstname" => "new name", "lastname" => "fake", "email" => "fake_email", "year" => "fake", "major" => "fake", "contestname" => "contest1", "team" => "awesome", "selectedteam" => "fake", "newteam" => "awesome"}).and_return(true)
            expect(@fake_result).to receive(:save!)
            @fake_team = Team.new(:captain => "3", :contestname => "contest1", :name => "awesome")
            expect(Team).to receive(:new).and_return(@fake_team)
            allow(@fake_team).to receive(:save!)
            post :update, parameters
            expect(response).to redirect_to('/registration')
        end
    end
    describe 'create' do
         before :each do
            #@fake_result = Registration.create!(:id => "3", :firstname => "Fake", :lastname => "fake", :email => "fake_email", :year => "fake", :major => "fake", :contestname => "contest1", :team => "fake")
            @fake_contest = Contest.create!(:contestname => "contest1", :contestdate => 2011-11-11, :id => "3")
            #allow(@fake_result).to receive(:contestname).and_return("Fake")
            allow(Contest).to receive(:find_by_contestname).and_return(@fake_contest)
            allow(@fake_contest).to receive(:contestname).and_return("contest1")
        end
        it 'should call model method to create new reg and redirect to index' do
            @fake_result = Registration.create!(:id => "3", :firstname => "Fake", :lastname => "fake", :email => "fake_email", :year => "fake", :major => "fake", :contestname => "contest1", :team => "fake")
            parameters = {:registration => {:id => 3, :firstname => "new name", :lastname => "fake", :email => "fake_email", :year => "fake", :major => "fake", :contestname => "contest1", :team => "fake"}}
            expect(Registration).to receive(:new).and_return(@fake_result)
            post :create, parameters
            expect(response).to redirect_to('/registration')
        end
        it 'be redirected to new when not valid' do
            @fake_result = Registration.create!(:id => "3", :firstname => "Fake", :lastname => "fake", :email => "fake_email", :year => "fake", :major => "fake", :contestname => "contest1", :team => "fake")
            parameters = {:registration => {:id => 3, :firstname => "new name", :lastname => "fake", :email => "fake_email", :year => "fake", :major => "fake", :contestname => "contest1", :team => "fake"}}
            expect(Registration).to receive(:new).with({"firstname" => "new name", "lastname" => "fake", "email" => "fake_email", "year" => "fake", "major" => "fake", "contestname" => "contest1", "team" => "fake"}).and_return(@fake_result)
            expect(@fake_result).to receive(:valid?).and_return false
            post :create, parameters
            expect(response).to render_template('registration/new')
        end
        it 'be redirected to new when team not valid' do
            Team.create!(:name => "Cobra", :contestname => "contest1", :captain => "3")
            @fake_result = Registration.create!(:userid => "3", :firstname => "Fake", :lastname => "fake", :email => "fake_email", :year => "fake", :major => "fake", :contestname => "contest1", :team => "Cobra")
            parameters = {:registration => {:userid => "3", :firstname => "new name", :lastname => "fake", :email => "fake_email", :year => "fake", :major => "fake", :contestname => "contest1", :team => "Create Own Team", :selectedteam => "fake", :newteam => "Cobra"}}
            pars = {"userid" => "3", "firstname" => "new name", "lastname" => "fake", "email" => "fake_email", "year" => "fake", "major" => "fake", "contestname" => "contest1", "team" => "awesome2", "selectedteam" => "fake", "newteam" => "Cobra"}

            allow(Registration).to receive(:new).with({"userid" => "3", "firstname" => "new name", "lastname" => "fake", "email" => "fake_email", "year" => "fake", "major" => "fake", "contestname" => "contest1", "team" => "Cobra", "selectedteam" => "fake", "newteam" => "Cobra"}).and_return(@fake_result)
            expect(@fake_result).to receive(:save!)
            @fake_t = Team.new(:captain => "3", :contestname => "contest1", :name => "awesome2")
            expect(Team).to receive(:new).and_return(@fake_t)
            expect(@fake_t).to receive(:valid?).and_return false
            post :create, parameters
            expect(response).to render_template('registration/new')
        end
        it 'should create new team!' do
            @fake_result = Registration.create!(:userid => "3", :firstname => "Fake", :lastname => "fake", :email => "fake_email", :year => "fake", :major => "fake", :contestname => "contest1", :team => "awesome2")
            parameters = {:registration => {:userid => "3", :firstname => "new name", :lastname => "fake", :email => "fake_email", :year => "fake", :major => "fake", :contestname => "contest1", :team => "Create Own Team", :selectedteam => "fake", :newteam => "awesome2"}}
            pars = {"userid" => "3", "firstname" => "new name", "lastname" => "fake", "email" => "fake_email", "year" => "fake", "major" => "fake", "contestname" => "contest1", "team" => "awesome2", "selectedteam" => "fake", "newteam" => "awesome2"}

            allow(Registration).to receive(:new).with({"userid" => "3", "firstname" => "new name", "lastname" => "fake", "email" => "fake_email", "year" => "fake", "major" => "fake", "contestname" => "contest1", "team" => "awesome2", "selectedteam" => "fake", "newteam" => "awesome2"}).and_return(@fake_result)
            expect(@fake_result).to receive(:save!)
            @fake_team = Team.new(:captain => "3", :contestname => "contest1", :name => "awesome2")
            expect(Team).to receive(:new).and_return(@fake_team)
            allow(@fake_team).to receive(:save!)
            post :create, parameters
            expect(response).to redirect_to('/registration')
        end
        it 'should select team' do
            @fake_result = Registration.create!(:userid => "3", :firstname => "Fake", :lastname => "fake", :email => "fake_email", :year => "fake", :major => "fake", :contestname => "contest1", :team => "awesome")
            parameters = {:registration => {:userid => "3", :firstname => "new name", :lastname => "fake", :email => "fake_email", :year => "fake", :major => "fake", :contestname => "contest1", :team => "Selected", :selectedteam => "awesome2", :newteam => "awesome2"}}
            allow(Registration).to receive(:new).with({"userid" => "3", "firstname" => "new name", "lastname" => "fake", "email" => "fake_email", "year" => "fake", "major" => "fake", "contestname" => "contest1", "team" => "awesome2", "selectedteam" => "awesome2", "newteam" => "awesome2"}).and_return(@fake_result)
            expect(@fake_result).to receive(:save!)
            post :create, parameters
            expect(response).to redirect_to('/registration')
        end
    end
    describe 'destroy' do
        it 'should call the destroy method' do
            @fake_result = Registration.create!(:id => "3", :firstname => "Fake", :userid => "3", :lastname => "fake", :email => "fake_email", :year => "fake", :major => "fake", :contestname => "contest1", :team => "fake")
            expect(Registration).to receive(:find).and_return(@fake_result)
            expect(@fake_result).to receive(:destroy)
            delete :destroy, id: 3
        end
    end
end
