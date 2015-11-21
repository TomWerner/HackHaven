class Question < ActiveRecord::Base
    has_many :testcases
    belongs_to :contest
    validates :title, presence: true, allow_blank: false
    validates :description, presence: true, allow_blank: false
    validates :contest_id, presence: true, allow_blank: false
end
