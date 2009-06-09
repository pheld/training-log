class AddFitnessSampleIndexes < ActiveRecord::Migration
  def self.up
    add_index :fitness_samples, :user_id
    add_index :fitness_samples, :date
  end

  def self.down
    remove_index :fitness_samples, :user_id
    remove_index :fitness_samples, :date
  end
end
