class Climb < ActiveRecord::Base
  GRAVITY = 9.796 # m/s^2
  POUNDS_TO_KILOGRAMS = 0.4536 
  FEET_TO_METERS = 0.3048 

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

  def power_to_weight
    average_watts = avg_power

    # power-to-weight ratio
    power_to_weight = average_watts / (self.weight_pounds * POUNDS_TO_KILOGRAMS)
  end

  def avg_power
    weight_kg = self.weight_pounds * POUNDS_TO_KILOGRAMS
    total_weight_kg = (self.weight_pounds + self.weight_of_equipment_pounds) * POUNDS_TO_KILOGRAMS
    altitude_gained_m = self.altitude_gained_feet * FEET_TO_METERS

    # total energy expended in the climb
    joules = GRAVITY * total_weight_kg * altitude_gained_m

    # average wattage produced
    average_watts = joules / self.duration_seconds
  end
end
