require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe FitnessSample do
  fixtures :users, :fitness_samples

  before(:each) do
    # do something?
  end

  it "should not be valid without a valid user_id" do
    fitness_sample = fitness_samples(:sample_one)
    fitness_sample.should be_valid
    fitness_sample.user_id = nil
    fitness_sample.should_not be_valid
  end 

  it "should not be valid without a date" do
    fitness_sample = fitness_samples(:sample_one)
    fitness_sample.should be_valid
    fitness_sample.date = nil
    fitness_sample.should_not be_valid
  end 

  it "should not be valid without a weight_pounds" do
    fitness_sample = fitness_samples(:sample_one)
    fitness_sample.should be_valid
    fitness_sample.weight_pounds = nil
    fitness_sample.should_not be_valid
  end

  it "should not be valid without a body_fat_percentage" do
    fitness_sample = fitness_samples(:sample_one)
    fitness_sample.should be_valid
    fitness_sample.body_fat_percentage = nil
    fitness_sample.should_not be_valid
  end
 
  it "should not be valid with negative weight_pounds" do
    fitness_sample = fitness_samples(:sample_one)
    fitness_sample.should be_valid
    fitness_sample.weight_pounds = -0.1
    fitness_sample.should_not be_valid
  end

  it "should not be valid with negative body_fat_percentage" do
    fitness_sample = fitness_samples(:sample_one)
    fitness_sample.should be_valid
    fitness_sample.body_fat_percentage = -0.1
    fitness_sample.should_not be_valid
  end

  it "should not be valid with a body_fat_percentage > 100" do
    fitness_sample = fitness_samples(:sample_one)
    fitness_sample.should be_valid
    fitness_sample.body_fat_percentage = 100.1
    fitness_sample.should_not be_valid
  end

end
