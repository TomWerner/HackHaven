class AddContestToTeam < ActiveRecord::Migration
  def change
    add_column :teams, :contestname, :string
  end
end
