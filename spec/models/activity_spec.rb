require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe Activity do
  fixtures :users, :activity_types

  before(:each) do
    @valid_activity = Activity.new(
      :description => 'test activity',
      :user_id => 1,
      :activity_type_id => 1,
      :date => "5/1/09",
      :duration_hours => 1.0,
      :distance_miles => 18.2
    )
  end

  it "should not be valid with a blank description" do
    activity = @valid_activity
    activity.description = nil
    activity.should_not be_valid
  end 

  it "should not be valid without a valid user_id" do
    activity = @valid_activity
    activity.user_id = nil
    activity.should_not be_valid
  end 

  it "should not be valid without a valid activity_type_id" do
    activity = @valid_activity
    activity.activity_type_id = nil
    activity.should_not be_valid
  end 

  it "should not be valid without a date" do
    activity = @valid_activity
    activity.date = nil
    activity.should_not be_valid
  end 

  it "should not be valid without a duration_hours" do
    activity = @valid_activity
    activity.duration_hours = nil
    activity.should_not be_valid
  end

  it "should not be valid with negative duration_hours" do
    activity = @valid_activity
    activity.should be_valid
    activity.duration_hours = -1.3
    activity.should_not be_valid
  end

  it "should not be valid with negative distance_miles" do
    activity = @valid_activity
    activity.should be_valid
    activity.distance_miles = -0.1
    activity.should_not be_valid
  end

end
