class Discussions < ActiveRecord::Migration
  def change
    create_table :discussions do |t|
      t.string :title
      t.string :content
      t.belongs_to :user, index: true
      t.belongs_to :question, index: true
      
      t.timestamps null: false
    end
  end
end
