class AddTeamToSubmission < ActiveRecord::Migration
  def change
    add_column :submissions, :team, :string
  end
end
