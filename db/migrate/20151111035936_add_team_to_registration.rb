class AddTeamToRegistration < ActiveRecord::Migration
  def change
    add_column :registrations, :team, :string
  end
end
