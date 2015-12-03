require 'spec_helper'
require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do

  describe "GET #index" do
    it "returns http success if logged in" do
      session[:session_token] = 123
      expect(User).to receive(:find_by_session_token).and_return(User.new(name: "Tom"))
      get :index, :session_token => "123"
      expect(response).to have_http_status(:success)
    end
    it "redirects to the login page if not logged in" do
      get :index
      expect(response).to redirect_to(login_path)
    end
    
    it "returns the questions" do
      Question.create!(title:"First Question", description:"My content", contest_id: "3")
      Question.create!(title:"Second Question", description:"Other content", contest_id: "3")
      questions = QuestionsController.new.index
      
      expect(questions.size).to equal(2)
      expect(questions[0].title).to eq("First Question")
      expect(questions[1].title).to eq("Second Question")
    end
  end
  
  describe 'GET #show' do
    it 'assigns the @question variable if logged in' do
      session[:session_token] = 123
      expect(User).to receive(:find_by_session_token).and_return(User.new(name: "Tom"))
      fake_result = double('question')
      expect(Question).to receive(:find).with('1').and_return(fake_result)
      expect(Compilebox).to receive(:get_languages).and_return([])
      get :show, id: 1
      expect(assigns(:question)).to eq(fake_result)
    end
    it "redirects to the login page if not logged in" do
      get :show, id: 1
      expect(response).to redirect_to(login_path)
    end
    it "checks the latest submissions - none" do
      session[:session_token] = 123
      Question.create!(title: "title", description: "description", contest_id: "3")
      expect(User).to receive(:find_by_session_token).and_return(
        User.create!(name: "Tom", email: "Tom", password: "Password"))
      empty_results = double('item')
      expect(Submission).to receive(:where).with(user_id: 1, question_id: "1").and_return(empty_results)
      expect(Compilebox).to receive(:get_languages).and_return([])
      expect(empty_results).to receive(:order).with(created_at: :desc).and_return([])
      get :show, id: 1
      expect(assigns(:last_submission)).to eq("")
      expect(assigns(:last_submission_language)).to eq(0)
      expect(response).to have_http_status(:success)
    end
    it "checks the latest submissions - multiple" do
      session[:session_token] = 123
      Question.create!(title: "title", description: "description", contest_id: "3")
      expect(User).to receive(:find_by_session_token).and_return(
        User.create!(name: "Tom", email: "Tom", password: "Password"))
      Submission.create!(code: "first", language: 1, user_id: 1, question_id: "1")
      Submission.create!(code: "second", language: 2, user_id: 1, question_id: "1")
      expect(Compilebox).to receive(:get_languages).and_return([])
      get :show, id: 1
      
      expect(assigns(:last_submission)).to eq("second")
      expect(assigns(:last_submission_language)).to eq(2)
      expect(response).to have_http_status(:success)
    end
  end
  
  describe 'GET #edit' do
    it 'assigns the @question variable if admin' do
      user = User.new(:name => "Kaitlyn", :email => "Kaitlyn@aol.com", :admin => 0, :password => "passCode")
      user.save
      session[:session_token] = user.session_token
      fake_result = double('question')
      expect(Question).to receive(:find).with('1').and_return(fake_result)
      get :edit, id: 1
      expect(assigns(:question)).to eq(fake_result)
    end
    it "redirects to the login page if not admin or not logged in" do
      get :edit, id: 1
      expect(response).to redirect_to(login_path)
    end
    it "redirects to the home page if not admin but logged in" do
      user = User.new(:name => "Kaitlyn", :email => "Kaitlyn@aol.com", :admin => 1, :password => "passCode")
      user.save
      session[:session_token] = user.session_token
      get :edit, id: 1
      expect(response).to redirect_to('/')
    end
  end
  
  describe "#new" do
    it "redirects to the home page if not admin but logged in" do
      user = User.new(:name => "Kaitlyn", :email => "Kaitlyn@aol.com", :admin => 1, :password => "passCode")
      user.save
      session[:session_token] = user.session_token
      get :new
      expect(response).to redirect_to('/')
    end
  end
  
  describe '#update' do
    it 'assigns updates @question variable if admin' do
      user = User.new(:name => "Kaitlyn", :email => "Kaitlyn@aol.com", :admin => 0, :password => "passCode")
      user.save
      session[:session_token] = user.session_token
      update = {question: {title: "New title", description: "New content"}}
      question = Question.create(title: "Title", description: "Content")
      expect(Question).to receive(:find).with("1").and_return(question)
      expect(question).to receive(:update_attributes!).with(update[:question])
      expect(question).to receive(:title).and_return("New title")
      update[:id] = 1
      post :update, update
      expect(flash[:notice]).to eq("'New title' was successfully updated.")
      expect(response).to redirect_to(questions_path)
    end
    it "redirects to the login page if not admin or not logged in" do
      update = {id: 1, question: {title: "New title", description: "New content"}}
      post :update, update
      expect(response).to redirect_to(login_path)
    end
    it "redirects to the home page if not admin but logged in" do
      user = User.new(:name => "Kaitlyn", :email => "Kaitlyn@aol.com", :admin => 1, :password => "passCode")
      user.save
      session[:session_token] = user.session_token
      update = {id: 1, question: {title: "New title", description: "New content"}}
      post :update, update
      expect(response).to redirect_to('/')
    end
  end
  
  describe '#create' do
    it 'creates the question if admin' do
      user = User.new(:name => "Kaitlyn", :email => "Kaitlyn@aol.com", :admin => 0, :password => "passCode")
      user.save
      session[:session_token] = user.session_token
      number = 1
      create_params = {question: {title: "Title", description: "Content", contest_id: "1"}}
      question = Question.create(title: "Title", description: "Content", contest_id: 1)
      expect(Question).to receive(:new).with(create_params[:question]).and_return(question)
      expect(question).to receive(:title).and_return("Title")
      expect(question).to receive(:title).and_return("Title")
      post :create, create_params
      expect(flash[:notice]).to eq("'Title' was successfully created.")
      expect(response).to redirect_to(questions_path)
    end
    it "redirects to the login page if not admin or not logged in" do
      create_params = {question: {title: "Title", description: "Content"}}
      post :create, create_params
      expect(response).to redirect_to(login_path)
    end
    it "redirects to the home page if not admin but logged in" do
      user = User.new(:name => "Kaitlyn", :email => "Kaitlyn@aol.com", :admin => 1, :password => "passCode")
      user.save
      session[:session_token] = user.session_token
      create_params = {question: {title: "Title", description: "Content"}}
      post :create, create_params
      expect(response).to redirect_to('/')
    end
    it "renders new if there are errors" do
      user = User.new(:name => "Kaitlyn", :email => "Kaitlyn@aol.com", :admin => 0, :password => "passCode")
      user.save
      session[:session_token] = user.session_token
      number = 1
      create_params = {question: {title: "Title", description: "Content", contest_id: "1"}}
      question = Question.create(title: "Title", description: "Content", contest_id: 1)
      expect(Question).to receive(:new).with(create_params[:question]).and_return(question)
      expect(question).to receive(:save).and_return(nil) #error with validations, couldn't save
      post :create, create_params
      expect(response).to render_template('new')
    end
  end
  
  describe '#destroy' do
    it 'destroys the question if admin' do
      user = User.new(:name => "Kaitlyn", :email => "Kaitlyn@aol.com", :admin => 0, :password => "passCode")
      user.save
      session[:session_token] = user.session_token
      destroy_params = {id: 1, question: {title: "Title", description: "Content"}}
      question = Question.create(title: "Title", description: "Content")
      expect(Question).to receive(:find).with("1").and_return(question)
      expect(question).to receive(:destroy)
      expect(question).to receive(:title).and_return("Title")
      post :destroy, destroy_params
      expect(flash[:notice]).to eq("'Title' was successfully deleted.")
      expect(response).to redirect_to(questions_path)
    end
    it "redirects to the login page if not admin or not logged in" do
      destroy_params = {id: 1, question: {title: "Title", description: "Content"}}
      post :destroy, destroy_params
      expect(response).to redirect_to(login_path)
    end
    it "redirects to the home page if not admin but logged in" do
      user = User.new(:name => "Kaitlyn", :email => "Kaitlyn@aol.com", :admin => 1, :password => "passCode")
      user.save
      session[:session_token] = user.session_token
      destroy_params = {id: 1, question: {title: "Title", description: "Content"}}
      post :destroy, destroy_params
      expect(response).to redirect_to('/')
    end
  end
  
  describe 'POST #submit' do
    before :each do
      @fake_result = Registration.create!(:userid => "3", :firstname => "Fake", :lastname => "fake", :email => "fake_email", :year => "fake", :major => "fake", :contestname => "contest1", :team => "awesome", :id => "3")
      @fake_result2 = Registration.create!(:userid => "4", :firstname => "Fake", :lastname => "fake", :email => "fake_email", :year => "fake", :major => "fake", :contestname => "contest2", :team => "aweesome", :id => "4")
      @results = [@fake_result, @fake_result2]
      allow(Question).to receive(:find).and_return(Question.new(id: 123, contest_id: 1))
      allow(Contest).to receive(:find).and_return(Contest.new(id: 1))
      allow(Registration).to receive(:where).and_return(@results)
    end
    it 'calls compilebox if logged in' do
      session[:session_token] = 123
      expect(User).to receive(:find_by_session_token).and_return(User.new(name: "Tom"))
      submission_params = {question_id: 123, submission: {language: "0", code: "print('Hello')"}}
      fake_results = ["test1", "test2", "test3"]
      expect(Compilebox).to receive(:submit_code).with("123", "0", "print('Hello')").and_return(fake_results)
      
      post :submit, submission_params
      
      expect(assigns(:results)).to eq(fake_results)
    end
    it "redirects to the login page if not logged in" do
      submission_params = {question_id: 123, submission: {language: "0", code: "print('Hello')"}}
      post :submit, submission_params
      expect(response).to redirect_to(login_path)
    end
    it "adds to the submission table with bad results" do
      session[:session_token] = 123
      expect(User).to receive(:find_by_session_token).and_return(
        User.create!(name: "Tom", email: "Tom", password: "Password"))
      submission_params = {question_id: 123, submission: {language: "0", code: "print('Hello')"}}
      
      fake_results = ["test1", "test2", "test3"]
      expect(Compilebox).to receive(:submit_code).with("123", "0", "print('Hello')").and_return(fake_results)
      
      expect(Submission).to receive(:create!).with({
        question_id: "123", user_id: 1, team: "awesome", code: "print('Hello')", 
        language: "0", correct: false
      })
      post :submit, submission_params
    end
    it "adds to the submission table with good results" do
      session[:session_token] = 123
      expect(User).to receive(:find_by_session_token).and_return(
        User.create!(name: "Tom", email: "Tom", password: "Password"))
      submission_params = {question_id: 123, submission: {language: "0", code: "print('Hello')"}}
      
      fake_results = ["Correct!", "Correct!", "Correct!"]
      expect(Compilebox).to receive(:submit_code).with("123", "0", "print('Hello')").and_return(fake_results)
      
      expect(Submission).to receive(:create!).with({
        question_id: "123", user_id: 1, code: "print('Hello')", team: "awesome", 
        language: "0", correct: true
      })
      post :submit, submission_params
    end
  end
  
  describe 'POST #submit_custom_testcase' do
    it 'calls compilebox if logged in' do
      session[:session_token] = 123
      expect(User).to receive(:find_by_session_token).and_return(User.new(name: "Tom"))
      submission_params = {question_id: 0, submission: {stdin: "input", language: "0", code: "print('Hello')"}}
      fake_results = ["test1", "test2", "test3"]
      expect(Compilebox).to receive(:get_output).with("0", "print('Hello')", "input").and_return(fake_results)
      
      post :submit_custom_testcase, submission_params
      
      
      expect(response.body).to eq(Compilebox.response.to_json)
    end
    it "redirects to the login page if not logged in" do
      submission_params = {question_id: 123, submission: {language: "0", code: "print('Hello')"}}
      post :submit_custom_testcase, submission_params
      expect(response).to redirect_to(login_path)
    end
  end
end
