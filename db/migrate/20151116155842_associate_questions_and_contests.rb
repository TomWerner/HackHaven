class AssociateQuestionsAndContests < ActiveRecord::Migration
  def change
    change_table :questions do |t|
      t.belongs_to :contest, index: true
    end
  end
end