class AddActivityIndexes < ActiveRecord::Migration
  def self.up
    add_index :activities, :user_id
    add_index :activities, :date
  end

  def self.down
    remove_index :activities, :user_id
    remove_index :activities, :date
  end
end
