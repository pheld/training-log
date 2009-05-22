class AddActivities < ActiveRecord::Migration
  def self.up
    create_table "activities" do |t|
      t.column "id", :integer
      t.column "user_id", :integer
      t.column "activity_type_id", :integer
      t.column "date", :date
      t.column "description", :text
      t.column "duration_hours", :float
      t.column "distance_miles", :float
    end
  end

  def self.down
    drop_table "activities"
  end
end
