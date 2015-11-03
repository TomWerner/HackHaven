class Registration < ActiveRecord::Base
    validates :contestname, :presence => true
    validates :email, :presence => true
    validates :firstname, :presence => true
    validates :lastname, :presence => true
    validates :year, :presence => true
    validates :major, :presence => true
end
