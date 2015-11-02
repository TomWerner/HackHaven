class TestcasesController < ApplicationController
  def testcase_params
    params.require(:testcase).permit(:stdin, :stdout)
  end
  
  def edit
    @question = Question.find params[:question_id]
    @testcase = Testcase.find params[:id]
  end

  def new
    @question = Question.find params[:question_id]
    #just displays the new template
  end
  
  def update
    @question = Question.find params[:question_id]
    @testcase = Testcase.find params[:id]
    @testcase.update_attributes!(testcase_params)
    flash[:notice] = "Test case successfully updated."
    redirect_to edit_question_path(@question)
  end

  def create
    @question = Question.find params[:question_id]
    @testcase = Testcase.create!(testcase_params)
    @question.testcases.push(@testcase)
    flash[:notice] = "Test case successfully created."
    redirect_to edit_question_path(@question)
  end
  
  def destroy
    @question = Question.find params[:question_id]
    @testcase = Testcase.find(params[:id])
    @testcase.destroy
    flash[:notice] = "Test case was successfully deleted."
    redirect_to edit_question_path(@question)
  end
end
