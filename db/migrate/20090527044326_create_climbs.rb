class CreateClimbs < ActiveRecord::Migration
  def self.up
    create_table :climbs do |t|
      t.integer :user_id
      t.date :date
      t.text :description
      t.integer :duration_seconds
      t.integer :altitude_gained_feet
      t.float :weight_pounds
      t.float :weight_of_equipment_pounds

      t.timestamps
    end
  end

  def self.down
    drop_table :climbs
  end
end
