class CreateSubmission < ActiveRecord::Migration
  def change
    create_table :submissions do |t|
      t.belongs_to :question
      t.belongs_to :user
      t.string :code
      t.integer :language
      t.boolean :correct
      
      t.timestamps null: false
    end
  end
end
