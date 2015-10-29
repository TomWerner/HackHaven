class CreateRegistrations < ActiveRecord::Migration
  def change
    create_table :registrations do |t|
      t.integer :userid
      t.string :contestname
      t.string :email
      t.string :firstname
      t.string :lastname

      t.timestamps null: false
    end
  end
end
