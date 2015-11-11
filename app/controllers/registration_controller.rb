class RegistrationController < ApplicationController
    
  def registration_params
    params.require(:registration).permit(:userid, :contestname, :email, :firstname, :lastname, :email, :year, :major, :selectedteam, :team, :newteam)
  end
  
  def full_reg_params
    params.require(:registration).permit(:userid, :contestname, :email, :firstname, :lastname, :email, :year, :major, :team)
  end

  def index
    if @current_user != nil
     @registrations = Registration.order(:created_at => :desc).where(:userid => @current_user.id)
    else
      @registrations = nil
    end
  end

  def edit
    @registration = Registration.find params[:id]
    
    @contest = Contest.find_by_contestname @registration.contestname
    @contestname = @contest.contestname
    if @current_user != nil
     @currentuserid = @current_user.id;
    else
     @currentuserid = nil
    end
    
    if Contest.all.blank?
      @contests_blank = true
    else
      @contests_blank = false
    end
    
    #@teams = [];
    #@teams.push Contest.new :contestname => "Team 1"
    #@teams.push Contest.new :contestname => "Team 2"
    @teams = Team.where(:contestname => @contestname)
  end

  def new
    @contest = Contest.find params[:id]
    @contestname = @contest.contestname
    if @current_user != nil
     @currentuserid = @current_user.id;
    else
     @currentuserid = nil
    end
    
    if Contest.all.blank?
      @contests_blank = true
    else
      @contests_blank = false
    end
    
    #@teams = [];
    #@teams.push Contest.new :contestname => "Team 1"
    #@teams.push Contest.new :contestname => "Team 2"
    @teams = Team.where(:contestname => @contestname)

  end
  
  # FIX THIS BUG:
  def update
    @registration = Registration.find params[:id]
    
     @reg = registration_params.to_h
    @registrar = registration_params.to_h
    if @reg["team"] == "Selected"
      @registrar["team"] = @reg["selectedteam"]
    elsif @reg["team"] == "Create Own Team"
      @registrar["team"] = @reg["newteam"]
    end
    
    @registration.update_attributes!(registration_params)
    flash[:notice] = "Registration for #{@registration.firstname} was successfully updated."
    redirect_to :action => "index"
  end

  # DISPLAY TEAMS OF USER
  def create
    @reg = registration_params.to_h
    @registrar = registration_params.to_h
    if @reg["team"] == "Selected"
      @registrar["team"] = @reg["selectedteam"]
    elsif @reg["team"] == "Create Own Team"
      @registrar["team"] = @reg["newteam"]
    end

    if (@registration = Registration.new(@registrar)).valid?
      @registration.save!
      
      if @reg["team"] == "Create Own Team"
        if(@newteam = Team.new(:captain => @registrar[:userid], :name => @reg["newteam"], :contestname => @reg["contestname"])).valid?
          @newteam.save!
          flash[:notice] = "You are now the captain of #{@newteam.name}."
        end
      end
      
      flash[:notice] = "Registration for #{@registration.firstname} was successfully created."
      redirect_to :action => "index"
    else
      @reg = registration_params
      @contest = Contest.find_by_contestname @reg["contestname"]
      
      if @contest == nil
        @contest = Contest.find params[:id]
      end
      
      if @current_user != nil
        @currentuserid = @current_user.id;
      else
        @currentuserid = nil
      end
      
      flash[:warning] = "Registration was not created. Please fix errors #{@registration.errors.full_messages}"
      @contestname = @contest.contestname
      #@teams = [];
      #@teams.push Contest.new :contestname => "Team 1"
      #@teams.push Contest.new :contestname => "Team 2"
      
      @teams = Team.where(:contestname => @contestname)
      
      render :action => "new", :id => @contest.id
    end
  end
end
