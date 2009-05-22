class AddActivityTypes < ActiveRecord::Migration
  def self.up
    create_table "activity_types" do |t|
      t.column "id", :integer
      t.column "name", :string
      t.column "description", :text
    end
  end

  def self.down
    drop_table "activity_types"
  end
end
