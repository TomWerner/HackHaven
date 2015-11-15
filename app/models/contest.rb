class Contest < ActiveRecord::Base
    validates :contestname, :presence => true
end
