class AddEmailConfToUsers < ActiveRecord::Migration
  def change
    add_column :users, :confirmed, :boolean
    add_column :users, :confirmation_code, :string
  end
end
