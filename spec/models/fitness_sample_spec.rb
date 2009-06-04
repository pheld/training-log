require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe Climb do
  fixtures :users, :activities

  before(:each) do
    @valid_climb = Climb.new(
      :activity_id => 1,
      :description => 'valid climb description',
      :duration_seconds => 500,
      :altitude_gained_feet => 1000,
      :weight_pounds => 165.0,
      :weight_of_equipment_pounds => 25.0
    )
  end

  it "should not be valid without a valid activity_id" do
    climb = @valid_climb
    climb.activity_id = nil
    climb.should_not be_valid
  end

  it "should not be valid with a blank description" do
    climb = @valid_climb
    climb.description = nil
    climb.should_not be_valid
  end

  it "should not be valid with a blank duration_seconds" do
    climb = @valid_climb
    climb.duration_seconds = nil
    climb.should_not be_valid
  end

  it "should not be valid with a blank altitude_gained_feet" do
    climb = @valid_climb
    climb.altitude_gained_feet = nil
    climb.should_not be_valid
 end

  it "should not be valid with a blank weight_pounds" do
    climb = @valid_climb
    climb.weight_pounds = nil
    climb.should_not be_valid
 end

  it "should not be valid with a blank weight_of_equipment_pounds" do
    climb = @valid_climb
    climb.weight_of_equipment_pounds = nil
    climb.should_not be_valid
 end

end
