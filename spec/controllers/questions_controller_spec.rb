require 'spec_helper'
require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
    
    it "returns the questions" do
      Question.create!(title:"First Question", description:"My content")
      Question.create!(title:"Second Question", description:"Other content")
      questions = QuestionsController.new.index
      
      expect(questions.size).to equal(2)
      expect(questions[0].title).to eq("First Question")
      expect(questions[1].title).to eq("Second Question")
    end
  end
  
  describe 'GET #show' do
    it 'assigns the @question variable' do
      fake_result = double('question')
      expect(Question).to receive(:find).with('1').and_return(fake_result)
      get :show, id: 1
      expect(assigns(:question)).to eq(fake_result)
    end
  end
  
  describe 'GET #edit' do
    it 'assigns the @question variable' do
      fake_result = double('question')
      expect(Question).to receive(:find).with('1').and_return(fake_result)
      get :edit, id: 1
      expect(assigns(:question)).to eq(fake_result)
    end
  end
  
  describe '#update' do
    it 'assigns updates @question variable' do
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
  end
  
  describe '#create' do
    it 'creates the question' do
      create_params = {question: {title: "Title", description: "Content"}}
      question = Question.create(title: "Title", description: "Content")
      expect(Question).to receive(:create!).with(create_params[:question]).and_return(question)
      expect(question).to receive(:title).and_return("Title")
      post :create, create_params
      expect(flash[:notice]).to eq("'Title' was successfully created.")
      expect(response).to redirect_to(questions_path)
    end
  end
  
  describe '#destroy' do
    it 'destroys the question' do
      destroy_params = {id: 1, question: {title: "Title", description: "Content"}}
      question = Question.create(title: "Title", description: "Content")
      expect(Question).to receive(:find).with("1").and_return(question)
      expect(question).to receive(:destroy)
      expect(question).to receive(:title).and_return("Title")
      post :destroy, destroy_params
      expect(flash[:notice]).to eq("'Title' was successfully deleted.")
      expect(response).to redirect_to(questions_path)
    end
  end
  
  describe 'POST #submit' do
    it 'calls compilebox' do
      submission_params = {question_id: 123, submission: {language: "0", code: "print('Hello')"}}
      fake_results = ["test1", "test2", "test3"]
      expect(Compilebox).to receive(:submit_code).with("123", "0", "print('Hello')").and_return(fake_results)
      
      post :submit, submission_params
      
      expect(assigns(:results)).to eq(fake_results)
    end
  end
end
