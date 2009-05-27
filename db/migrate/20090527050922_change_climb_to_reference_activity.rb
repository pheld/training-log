class ChangeClimbToReferenceActivity < ActiveRecord::Migration
  def self.up
    add_column :climbs, :activity_id, :integer
    remove_column :climbs, :user_id
    remove_column :climbs, :date
  end

  def self.down
    remove_column :climbbs, :activity_id
    add_column :climbs, :user_id, :integer
    add_column :climbs, :date, :date
  end
end
