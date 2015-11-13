class RegistrationController < ApplicationController
    
  def registration_params
    params.require(:registration).permit(:userid, :contestname, :email, :firstname, :lastname, :email, :year, :major, :selectedteam, :team, :newteam)
  end

  def index
    if @current_user != nil
     @registrations = Registration.order(:created_at => :desc).where(:userid => @current_user.id)
     
     if Contest.all.blank?
        @contests = nil
     else
        @contests = Contest.all
        @m_contests = []
        @contests.each do |c|
          if Registration.where(:userid => @current_user.id, :contestname => c.contestname) == []
            @m_contests.push(c)
          end
        end
      end
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
    
    @contests_blank = Contest.all.blank?
    if (Team.where(:name => @registration.team, :contestname => @registration.contestname)).first != nil
      @teamcaptain = (Team.where(:name => @registration.team, :contestname => @registration.contestname)).first.captain
    else
      @teamcaptain = nil
    end
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
    
    @contests_blank = Contest.all.blank?

    @teams = Team.where(:contestname => @contestname)

  end

  def update
    @registration = Registration.find params[:id]
    
    @reg = registration_params.to_h
    @registrar = registration_params.to_h
    if @reg["team"] == "Selected"
      @registrar["team"] = @reg["selectedteam"]
    elsif @reg["team"] == "Create Own Team"
      @registrar["team"] = @reg["newteam"]
    end
    
    if @registration.update_attributes(@registrar)
      @registration.save!
      if @reg["team"] == "Create Own Team"
          if(@newteam = Team.new(:captain => @registrar["userid"], :name => @reg["newteam"], :contestname => @reg["contestname"])).valid?
            @newteam.save!
            flash[:notice] = "You are now the captain of #{@newteam.name}."
          end
      end
        
      flash[:notice] = "Registration for #{@registration.firstname} was successfully updated."
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
      
      flash[:warning] = "Registration was not updated. Please fix errors #{@registration.errors.full_messages}"
      @contestname = @contest.contestname
      
      @teams = Team.where(:contestname => @contestname)
      
      render :action => "edit", :id => @registration.id
    end
  end
  
  def destroy
        @registration = Registration.find params[:id]
        @registration.destroy
        flash[:notice] = "Registration for #{@registration.firstname} was successfully destroyed!"
        redirect_to :action => "index"
  end

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
      #Note to self: look into that one lecture and make this that cool relationally db way
      if @reg["team"] == "Create Own Team"
        if(@newteam = Team.new(:captain => @registrar["userid"], :name => @reg["newteam"], :contestname => @reg["contestname"])).valid?
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
      
      @teams = Team.where(:contestname => @contestname)
      
      render :action => "new", :id => @contest.id
    end
  end
end
