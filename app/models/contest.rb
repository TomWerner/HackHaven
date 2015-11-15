class Contest < ActiveRecord::Base
<<<<<<< HEAD
    has_many :questions
=======
    validates :contestname, :presence => true
>>>>>>> b2bfc1e8ea237c3efb95a1c2981f523bfb979785
end
