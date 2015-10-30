class HomeController < ApplicationController
  before_filter :set_current_user
  
  def index
  end
end
