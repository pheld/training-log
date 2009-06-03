require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe Activity do

  before(:each) do
    # something?
  end

  it "should not be valid with a blank password" do
    user = User.new(:login => 'valid_login', :password => nil)
    user.should_not be_valid
  end

  it "should not be valid with a blank login" do
    user = User.new(:login => nil, :password => 'valid_password')
    user.should_not be_valid
  end

end
