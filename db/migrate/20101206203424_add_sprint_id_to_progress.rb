class AddSprintIdToProgress < ActiveRecord::Migration
  def self.up
    add_column :progresses, :sprint_id, :integer
  end

  def self.down
    remove_column :progresses, :sprint_id
  end
end
