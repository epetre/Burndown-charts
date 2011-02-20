class CreateSprints < ActiveRecord::Migration
  def self.up
    create_table :sprints do |t|
      t.string :name
      t.date :start_date
      t.integer :duration
      t.integer :total_points

      t.timestamps
    end
  end

  def self.down
    drop_table :sprints
  end
end
