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
        it 'should call model method to find registration based on id' do
            @fake_result = double('reg1')
            expect(Registration).to receive(:find).with('3').and_return(@fake_result)
            get :edit, id: 3
        end
        it 'should assign registration found by reg id to registration variable' do
           @fake_result = double('reg1')
           allow(Registration).to receive(:find).with('3').and_return(@fake_result)
           get :edit, id: 3
           expect(assigns(:registration)).to eq @fake_result 
        end
    end
    describe 'new' do
        it 'should render the new template' do
            get :new
            expect(response).to render_template('new')
        end
        it 'should assign nil to currentuserid because no user logged in' do
            expect(assigns(:currentuserid)).to eq nil
            get :new
        end
    end
    describe 'update' do
        it 'should update firstname attribute' do
            @fake_result = Registration.create!(:id => "3", :firstname => "Fake", :lastname => "fake", :email => "fake_email", :year => "fake", :major => "fake", :contestname => "contest1")
            expect(Registration).to receive(:find).with('3').and_return(@fake_result)
            parameters = {:id => '3', :registration => {:id => 3, :firstname => "new name"}}
            expect(@fake_result).to receive(:update_attributes!).with({:firstname => "new name"})
            post :update, parameters
        end
        it 'should redirect to index' do
            @fake_result = Registration.create!(:id => "3", :firstname => "Fake", :lastname => "fake", :email => "fake_email", :year => "fake", :major => "fake", :contestname => "contest1")
            allow(Registration).to receive(:find).with('3').and_return(@fake_result)
            parameters = {:id => '3', :registration => {:id => 3, :firstname => "new name"}}
            allow(@fake_result).to receive(:update_attributes!).with({:firstname => "new name"})
            post :update, parameters
            expect(response).to redirect_to('/registration')
        end
    end
    describe 'create' do
        it 'should call model method to create new reg and redirect to index' do
            @fake_result = Registration.create!(:id => "3", :firstname => "Fake", :lastname => "fake", :email => "fake_email", :year => "fake", :major => "fake", :contestname => "contest1")
            parameters = {:id => '3', :registration => {:id => 3, :firstname => "new name", :lastname => "fake", :email => "fake_email", :year => "fake", :major => "fake", :contestname => "contest1"}}
            expect(Registration).to receive(:new).and_return(@fake_result)
            post :create, parameters
            expect(response).to redirect_to('/registration')
        end
    end
end
