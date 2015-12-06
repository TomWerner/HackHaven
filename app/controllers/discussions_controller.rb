class DiscussionsController < ApplicationController
   before_filter :restrict_to_logged_in_users
   
   def restrict_to_logged_in_users
    if @current_user == nil
      flash[:notice] = "You need to be logged in to see discussions."
      redirect_to login_path
    end
   end
   
   def discussion_params
      params.require(:discussion).permit(:title, :content)
   end
   
   def index
      @question = Question.find params[:question_id]
      @discussions = Discussion.where(question_id: params[:question_id])
   end
   
   def new
      @question = Question.find params[:question_id]
   end
   
   def create
      parameters = {title: discussion_params[:title], content: discussion_params[:content], user_id: @current_user.id, question_id: params[:question_id]}
      @discussion = Discussion.create!(parameters)
      flash[:notice] = "Discussion '#{@discussion.title}' was successfully created."
      redirect_to question_discussions_path(@discussion.question_id)
   end
   
   def edit
      @discussion = Discussion.find params[:id]
      @question = Question.find params[:question_id]
   end
   
   def update
      @discussion = Discussion.find params[:id]
      @discussion.update_attributes!(discussion_params)
      flash[:notice] = "'#{@discussion.title}' was successfully updated."
      redirect_to question_discussions_path(@discussion.question_id)
   end
   
   
end