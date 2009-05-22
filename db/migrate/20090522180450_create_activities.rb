class CreateActivities < ActiveRecord::Migration
  def self.up
    create_table :activities do |t|
      t.integer :id
      t.integer :user_id
      t.integer :activity_type_id
      t.date :date
      t.text :description
      t.float :duration_hours
      t.float :distance_miles

      t.timestamps
    end
  end

  def self.down
    drop_table :activities
  end
end
