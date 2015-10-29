class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.integer :role
      t.string :password_hash
      t.string :password_salt
    end
  end
end
