require 'spec_helper'
require 'rails_helper'

RSpec.describe TestcasesController, type: :controller do
  describe 'GET #new' do
    it 'assigns the @question variable' do
      fake_result = double('question')
      expect(Question).to receive(:find_by_id).with('1').and_return(fake_result)
      get :new, question_id: 1
      expect(assigns(:question)).to eq(fake_result)
    end
  end
  
  describe 'GET #edit' do
    it 'assigns the @question and @testcase variable' do
      fake_result = double('question')
      fake_result2 = double('testcase')
      expect(Question).to receive(:find_by_id).with('1').and_return(fake_result)
      expect(Testcase).to receive(:find).with('1').and_return(fake_result2)
      get :edit, question_id: 1, id: 1
      expect(assigns(:question)).to eq(fake_result)
      expect(assigns(:testcase)).to eq(fake_result2)
    end
  end
  
  describe '#update' do
    it 'assigns updates @question and @testcase variable' do
      update = {testcase: {stdin: "New input", stdout: "New output"}}
      question = Question.create(title: "Title", description: "Content")
      testcase = Testcase.create(stdin: "Input", stdout: "Output")
      expect(Question).to receive(:find_by_id).with("1").and_return(question)
      expect(Testcase).to receive(:find).with("123").and_return(testcase)
      expect(testcase).to receive(:update_attributes!).with(update[:testcase])
      update[:id] = 123
      update[:question_id] = 1
      post :update, update
      expect(flash[:notice]).to eq("Test case successfully updated.")
      expect(response).to redirect_to(edit_question_path(question))
    end
  end
  
  describe '#create' do
    it 'creates the question' do
      create_params = {testcase: {stdin: "Input", stdout: "Output"}}
      question = Question.create(title: "Title", description: "Content")
      testcase = Testcase.create(stdin: "in", stdout: "out")
      expect(Testcase).to receive(:create!).with(create_params[:testcase]).and_return(testcase)
      expect(Question).to receive(:find_by_id).with("1").and_return(question)
      expect(question.testcases).to receive(:push).with(testcase)
      
      create_params[:question_id] = 1
      post :create, create_params
      expect(flash[:notice]).to eq("Test case successfully created.")
      expect(response).to redirect_to(edit_question_path(question))
    end
  end
  
  describe '#destroy' do
    it 'destroys the question' do
      destroy_params = {question_id: 1, id: 1, testcase: {stdin: "In", stdout: "Out"}}
      testcase = Testcase.create(stdin: "In", stdout: "Out")
      question = Question.create(title: "Title", description: "Content")
      expect(Question).to receive(:find_by_id).with("1").and_return(question)
      expect(Testcase).to receive(:find).with("1").and_return(testcase)
      expect(testcase).to receive(:destroy)
      post :destroy, destroy_params
      expect(flash[:notice]).to eq("Test case was successfully deleted.")
      expect(response).to redirect_to(edit_question_path(question))
    end
  end
  
  describe 'before_filter' do
    it 'should only let valid questions through' do
      fake_result = double('testcase')
      expect(Question).to receive(:find_by_id).with('2').and_return(nil)
      get :edit, question_id: 2, id: 1
      expect(response).to redirect_to(questions_path)
      expect(flash[:warning]).to eq("Invalid question id.")
    end
  end
end
