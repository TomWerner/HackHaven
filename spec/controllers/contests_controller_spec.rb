require 'spec_helper'
require 'rails_helper'
require 'active_support'
require 'active_support/core_ext'

RSpec.describe ContestsController, type: :controller do
    describe 'index page' do
        it 'should render the index template' do
            get :index
            expect(response).to render_template('index')
        end
        it 'should display no contests because none in db' do
            expect(assigns(:contests)).to eq nil
            get:index
        end
        it 'should display 1 contest from db' do
            @fake_con = Contest.create!(:contestname => "The Contest", :contestdate => 2015-11-11)
            @fake_array = [@fake_con]
            expect(Contest).to receive(:all).and_return(@fake_array)
            expect(Contest).to receive(:all).and_return(@fake_array)
            get :index
        end
    end
    describe 'edit' do
        it 'should call model method to find contest based on id' do
            @fake_result = double('contest1')
            expect(Contest).to receive(:find).with('2').and_return(@fake_result)
            get :edit, id: 2
        end
        it 'should assign contest found by reg id to contest' do
            @fake_result = double('elcontesto')
            allow(Contest).to receive(:find).with('2').and_return(@fake_result)
            get :edit, id: 2
            expect(assigns(:contest)).to eq @fake_result
        end
    end
    describe 'new' do
        it 'should render new template' do
            get :new
            expect(response).to render_template('new')
        end
    end
    describe 'update' do
        it 'should update contestname attribute' do
            @fake_result = double('fake_contest')
            expect(Contest).to receive(:find).with('2').and_return(@fake_result)
            parameters = {:id => '2', :contest => {"contestname" => "new name", "contestdate(1i)" => 2015, "contestdate(2i)" => 11, "contestdate(3i)" => 11}}
            date = Date.new(2015, 11, 11)
            expect(@fake_result).to receive(:update_attributes!).with({"contestname" => "new name", "contestdate" => date})
            post :update, parameters
        end
        it 'should redirect to index' do
            @fake_result = double('fake_contest')
            allow(Contest).to receive(:find).with('2').and_return(@fake_result)
            parameters = {:id => '2', :contest => {"contestname" => "new name", "contestdate(1i)" => 2015, "contestdate(2i)" => 11, "contestdate(3i)" => 11}}
            date = Date.new(2015, 11, 11)
            allow(@fake_result).to receive(:update_attributes!).with({"contestname" => "new name", "contestdate" => date})
            post :update, parameters
            expect(response).to redirect_to('/contests')
        end
    end
    describe 'create' do
        it 'should call model method to create new contest and redirect to index' do
            date = Date.new(2015, 11, 11)
            @fake_result = Contest.create!(:id => "3", :contestname => "fake name", :contestdate => date)
            parameters = {:id => '2', :contest => {"contestname" => "fake name", "contestdate(1i)" => 2015, "contestdate(2i)" => 11, "contestdate(3i)" => 11}}
            expect(Contest).to receive(:new).and_return(@fake_result)
            post :create, parameters
            expect(response).to redirect_to('/contests')
        end
        it 'should render new template when not valid' do
            parameters = {:id => '2', :contest => {"contestname" => "", "contestdate(1i)" => 2015, "contestdate(2i)" => 11, "contestdate(3i)" => 11}}
            post :create, parameters
            expect(response).to render_template("new")
        end
    end
    describe 'destroy' do
        before :each do
            @fake_contest = Contest.create!(:contestname => "Java", :contestdate => 2015-11-11)
        end
        it 'should call destroy method on contest' do
            allow(Contest).to receive(:find).and_return(@fake_contest)
            expect(@fake_contest).to receive(:destroy)
            delete :destroy, id: 1
        end
    end
end
