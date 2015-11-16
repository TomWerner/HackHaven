class Question < ActiveRecord::Base
    has_many :testcases
    belongs_to :contest
end
