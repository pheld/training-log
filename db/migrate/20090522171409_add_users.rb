class AddUsers < ActiveRecord::Migration
  def self.up
    create_table "users" do |t|
      t.column "id", :integer
      t.column "login", :string
      t.column "password", :string
      t.column "is_admin", :boolean
    end
  end

  def self.down
    drop_table "users"
  end
end
