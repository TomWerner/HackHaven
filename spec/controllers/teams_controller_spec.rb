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
            get:index
        end
    end
end
