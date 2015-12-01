class Team < ActiveRecord::Base
    validate :is_unique_to_contest
    
    def is_unique_to_contest
        @teams = Team.where(:contestname => contestname, :name => name)
        if @teams != nil
            @teams.each do |team|
                if team.id != id
                    errors.add(:userid, "Team Name Taken")
                end
            end
        end
    end
end
