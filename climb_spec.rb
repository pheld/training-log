require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe FitnessSample do
  fixtures :users

  before(:each) do
    @valid_fitness_sample = FitnessSample.new(
      :user_id => 1,
      :date => '5/1/09',
      :weight_pounds => 165.0,
      :body_fat_percentage => 9.3
    )
  end

  it "should not be valid with a blank date" do
    fitness_sample = @valid_fitness_sample
    fitness_sample.date = nil
    fitness_sample.should_not be_valid
  end

  it "should not be valid with a blank weight_pounds" do
    fitness_sample = @valid_fitness_sample
    fitness_sample.weight_pounds = nil
    fitness_sample.should_not be_valid
  end

  it "should not be valid with a blank body_fat_percentage"   do
    fitness_sample = @valid_fitness_sample
    fitness_sample.body_fat_percentage = nil
    fitness_sample.should_not be_valid
  end

end
