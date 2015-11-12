class AddChangeToRegistration < ActiveRecord::Migration
  def change
    add_column :registrations, :selectedteam, :string
    add_column :registrations, :newteam, :string
  end
end
