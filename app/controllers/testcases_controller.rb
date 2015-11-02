class TestcasesController < ApplicationController
  #before_filter :set_current_question
  before_filter :has_question
  
  def has_question
    unless (@question = Question.find_by_id(params[:question_id]))
      flash[:warning] = "Invalid question id."
      redirect_to questions_path
    end
  end
  
  def testcase_params
    params.require(:testcase).permit(:stdin, :stdout)
  end
  
  def edit
    @testcase = Testcase.find params[:id]
  end

  def new
    #just displays the new template
  end
  
  def update
    @testcase = Testcase.find params[:id]
    @testcase.update_attributes!(testcase_params)
    flash[:notice] = "Test case successfully updated."
    redirect_to edit_question_path(@question)
  end

  def create
    @testcase = Testcase.create!(testcase_params)
    @question.testcases.push(@testcase)
    flash[:notice] = "Test case successfully created."
    redirect_to edit_question_path(@question)
  end
  
  def destroy
    @testcase = Testcase.find(params[:id])
    @testcase.destroy
    flash[:notice] = "Test case was successfully deleted."
    redirect_to edit_question_path(@question)
  end
end
