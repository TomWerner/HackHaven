class QuestionsController < ApplicationController
  before_filter :restrict_to_logged_in_users
  
  def restrict_to_logged_in_users
    if !@current_user
      flash[:notice] = "You need to be logged in to see questions."
      redirect_to login_path
    end
  end
  
  def question_params
    params.require(:question).permit(:title, :description)
  end
  
  def submit
    @results = Compilebox.submit_code(params[:question_id], params[:submission][:language], params[:submission][:code])
    Submission.create!({question_id: params[:question_id], 
      user_id: @current_user.id, 
      code: params[:submission][:code],
      language: params[:submission][:language],
      correct: ((@results.select {|x| x =~ /^Correct!$/}) == @results)
    })
  end

  def index
    @questions = Question.all
  end

  def show
    @question = Question.find params[:id]
    last_submission = Submission.where( user_id: @current_user.id, question_id: params[:id]).order(created_at: :desc)
    if last_submission.length == 0
      @last_submission = ""
      @last_submission_language = 0
    else
      @last_submission = last_submission[0].code
      @last_submission_language = last_submission[0].language
    end
    result = []
    Compilebox.get_languages.each_with_index { |item, index| result.push([item, index]) }
    @languages = result
  end
  
  def edit
    @question = Question.find params[:id]
  end

  def new
    #just displays the new template
  end
  
  def update
    @question = Question.find params[:id]
    @question.update_attributes!(question_params)
    flash[:notice] = "'#{@question.title}' was successfully updated."
    redirect_to questions_path
  end

  def create
    @question = Question.create!(question_params)
    flash[:notice] = "'#{@question.title}' was successfully created."
    redirect_to questions_path
  end
  
  def destroy
    @question = Question.find(params[:id])
    @question.destroy
    flash[:notice] = "'#{@question.title}' was successfully deleted."
    redirect_to questions_path
  end
end
