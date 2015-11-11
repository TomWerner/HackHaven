class Registration < ActiveRecord::Base
    validates :contestname, :presence => true
    validates :email, :presence => true
    validates :firstname, :presence => true
    validates :lastname, :presence => true
    validates :year, :presence => true
    validates :major, :presence => true
    validates :team, :presence => true
    
    validate :not_already_registered
    
    def not_already_registered
        @regs = Registration.where(:userid => userid)
        if @regs != nil
            @regs.each do |reg|
                if reg.contestname == contestname
                    errors.add(:userid, "Already Registered For Selected Contest")
                end
            end
        end
    end
end
