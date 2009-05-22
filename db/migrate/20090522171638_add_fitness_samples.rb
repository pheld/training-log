class AddFitnessSamples < ActiveRecord::Migration
  def self.up
    create_table "fitness_samples" do |t|
      t.column "id", :integer
      t.column "user_id", :integer
      t.column "date", :date
      t.column "weight", :float
      t.column "body_fat_percentage", :float
    end
  end

  def self.down
    drop_table "fitness_samples"
  end
end
