require 'date'

class ContestsController < ApplicationController
    def index
        if Contest.all.blank?
            @contests = nil
        else
            @contests = Contest.all
        end
    end
    
    def edit
        require_admin
        @contest = Contest.find params[:id]
    end
    
    def new
        require_admin
    end
    
    def update
        require_admin
        @contest = Contest.find params[:id]
        param_hash = {}
        param_hash["contestname"] = params[:contest]["contestname"]
        param_hash["contestdate"] = Date.new params[:contest]["contestdate(1i)"].to_i, params[:contest]["contestdate(2i)"].to_i, params[:contest]["contestdate(3i)"].to_i
        @contest.update_attributes!(param_hash)
        flash[:notice] = "Contest Updated"
        redirect_to :action => "index"
    end
    
    def destroy
        require_admin
        @contest = Contest.find params[:id]
        @contest.destroy
        flash[:notice] = "#{@contest.contestname} was successfully destroyed!"
        redirect_to :action => "index"
    end
    
    def create
        require_admin
        param_hash = {}
        param_hash["contestname"] = params[:contest]["contestname"]
        param_hash["contestdate"] = Date.new params[:contest]["contestdate(1i)"].to_i, params[:contest]["contestdate(2i)"].to_i, params[:contest]["contestdate(3i)"].to_i

        if(@contest = Contest.new(param_hash)).valid?
            @contest.save!
            flash[:notice] = "Contest created"
            redirect_to :action => "index"
        else
            flash[:warning] = "Contest not created"
            render :action => "new"
        end
    end
end
