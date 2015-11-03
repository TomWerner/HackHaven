class CreateTestcases < ActiveRecord::Migration
  def change
    create_table :testcases do |t|
      t.belongs_to :question, index: true
      t.string :stdin
      t.string :stdout

      t.timestamps null: false
    end
  end
end
