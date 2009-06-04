class Climb < ActiveRecord::Base
  belongs_to :user
  belongs_to :activity

  validates_presence_of :description, :duration_seconds, :altitude_gained_feet, :weight_pounds, :weight_of_equipment_pounds

  validate :must_have_valid_activity

  # will-paginate
  def self.per_page
    5
  end

  def must_have_valid_activity
    if (self.activity_id.nil?)
      errors.add_to_base("Must belong to a valid activity.")
    else
      errors.add_to_base("Must belong to a valid activity.") unless !Activity.find(self.activity_id).nil?
    end
  end
end
