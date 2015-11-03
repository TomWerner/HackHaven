class QuestionsController < ApplicationController
  def question_params
    params.require(:question).permit(:title, :description)
  end
  
  def submit
    @results = Compilebox.submit_code(params[:question_id], params[:submission][:language], params[:submission][:code])
  end

  def index
    @questions = Question.all
  end

  def show
    @question = Question.find params[:id]
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
