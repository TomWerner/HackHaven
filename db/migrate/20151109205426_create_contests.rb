class CreateContests < ActiveRecord::Migration
  def change
    create_table :contests do |t|
      t.string :contestname
      t.date :contestdate

      t.timestamps null: false
    end
  end
end
