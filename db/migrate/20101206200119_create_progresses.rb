class CreateProgresses < ActiveRecord::Migration
  def self.up
    create_table :progresses do |t|
      t.string :description
      t.integer :points
      t.date :apply_date

      t.timestamps
    end
  end

  def self.down
    drop_table :progresses
  end
end
