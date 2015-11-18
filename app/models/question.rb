class Question < ActiveRecord::Base
    has_many :testcases
    validates :title, presence: true, allow_blank: false
    validates :description, presence: true, allow_blank: false
end
