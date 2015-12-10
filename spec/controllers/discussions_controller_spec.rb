require 'spec_helper'
require 'rails_helper'

RSpec.describe DiscussionsController, type: :controller do
  describe "GET #index" do
    before :each do
      Question.create!(title:"First Question", description:"My content", contest_id: "3")
    end
    it "returns http success if logged in" do
      session[:session_token] = 123
      expect(User).to receive(:find_by_session_token).and_return(User.new(name: "Tom"))
      get :index, question_id: (Question.find 1).id, :session_token => "123"
      expect(response).to have_http_status(:success)
    end
    it "redirects to the login page if not logged in" do
      get :index, question_id: (Question.find 1).id
      expect(response).to redirect_to(login_path)
    end
  end
  
end