require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe ActivityType do
  fixtures :users, :activity_types

  before(:each) do
    # something?
  end

  it "should not be valid without a name" do
    activity_type = activity_types(:road_cycling)
    activity_type.should be_valid
    activity_type.name = nil
    activity_type.should_not be_valid
  end

end
