class QuestionsController < ApplicationController
  before_filter :restrict_to_logged_in_users
  
  def restrict_to_logged_in_users
    if @current_user == nil
      flash[:notice] = "You need to be logged in to see questions."
      redirect_to login_path
    end
  end
  
  def question_params
    params.require(:question).permit(:title, :description, :contest_id)
  end
  
  def submit
    if @current_user.confirmed == false
      flash[:notice] = "Sorry, please confirm your email account to do that"
      redirect_to '/'
      return
    end
    @results = Compilebox.submit_code(params[:question_id], params[:submission][:language], params[:submission][:code])
    @question = Question.find params[:question_id]
    @contest = Contest.find @question.contest_id
    @reg = Registration.where(userid: @current_user.id, contestname: @contest.contestname).first
    if @reg != nil
      @team = @reg.team
      @already_sub = (Submission.where(team: @team, question_id: params[:question_id] ) != [])
    else
      @team = 'None'
      @already_sub = true
    end
    
    @submission = Submission.create!({question_id: params[:question_id], 
      user_id: @current_user.id, 
      code: params[:submission][:code],
      team: @team,
      language: params[:submission][:language],
      correct: ((@results.select {|x| x =~ /^Correct!$/}) == @results)
    })
    
    if @submission != nil
      if !@submission.correct
        @incorrect_results = @results.select{|result| !result.eql?("Correct!")}
        @incorrect_example = @incorrect_results.sample(1)[0]
        number_correct = (@results.count - @incorrect_results.count).to_f
        total_results = @results.count.to_f
        @percent_correct = (number_correct / total_results) * 100.0
      end
    end
    
    if @submission != nil && !@already_sub
      if @submission.correct
        @team_a = Team.where(name: @team, contestname: @contest.contestname).first
        @team_a.points = @team_a.points + 1
        @team_a.save!
      end
    end
    @submission
  end
  
  def submit_custom_testcase
    if @current_user.confirmed == false
      flash[:notice] = "Sorry, please confirm your email account to do that"
      redirect_to '/'
      return
    end
    
    language = params[:submission][:language]
    code = params[:submission][:code]
    stdin = params[:submission][:stdin]
    
    Compilebox.get_output(language, code, stdin)
    render :json => Compilebox.response
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
    if @admin != 0
      redirect_to('/') and return
    end
    @question = Question.find params[:id]
  end

  def new
    if @admin != 0
      redirect_to('/') and return
    end
    #just displays the new template
  end
  
  def update
    if @admin != 0
      redirect_to('/') and return
    end
    @question = Question.find params[:id]
    @question.update_attributes!(question_params)
    flash[:notice] = "'#{@question.title}' was successfully updated."
    redirect_to questions_path
  end

  def create
    if @admin != 0
      redirect_to('/') and return
    end
    @question = Question.new(question_params)
    if @question.save
      flash[:notice] = "'#{@question.title}' was successfully created."
      redirect_to questions_path
    else
      render 'new'
    end
  end
  
  def destroy
    if @admin != 0
      redirect_to('/') and return
    end
    @question = Question.find(params[:id])
    @question.destroy
    flash[:notice] = "'#{@question.title}' was successfully deleted."
    redirect_to questions_path
  end
end
