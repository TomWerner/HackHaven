class TeamsController < ApplicationController
  def index
    if Team.all.blank?
        @teams = nil
    else
        @teams = Team.order(:contestname => :desc)
    end
  end
  
  def leaderboard
    if Team.all.blank?
        @teams = nil
    else
        @teams = Team.where(contestname: params[:contestname]).order(:points => :desc)
    end
  end
  
  def show
    @team = Team.find params[:id]
    @regs = Registration.where(:team => @team.name)
    @users = []
    @regs.each do |reg|
        @users.push User.find reg.userid
    end
  end
  
  def destroy
        @team = Team.find params[:id]
        @regs = Registration.where(:team => @team.name)
        
        @regs.each do |reg|
            reg.team = "None"
            reg.save!
        end
        @team.destroy
        flash[:notice] = "#{@team.name} was successfully destroyed!"
        redirect_to :action => "index"
  end
  
  def remove
      @userid = params[:id]
      @registration = Registration.find_by_userid @userid
      @registration.team = "None"
      @registration.save!
      flash[:notice] = "Removed user from team."
      redirect_to :action => "index"
  end
  
  def captainize
      @userid = params[:id]
      @team = Team.find params[:teamid]
      @team.captain = @userid
      @team.save!
      flash[:notice] = "Captainized user."
      redirect_to :action => "index"
  end
end
