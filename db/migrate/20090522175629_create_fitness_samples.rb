class CreateFitnessSamples < ActiveRecord::Migration
  def self.up
    create_table :fitness_samples do |t|
      t.integer :id
      t.integer :user_id
      t.date :date
      t.float :weight
      t.float :body_fat_percentage

      t.timestamps
    end
  end

  def self.down
    drop_table :fitness_samples
  end
end
