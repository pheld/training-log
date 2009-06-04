require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe User do

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

  it "should require at least 5 characters in the login field" do
    user = User.new(:login => 'abcd', :password => 'abcde')
    user.should_not be_valid
    user.login = 'abcde'
    user.should be_valid
  end

  it "should require at least 5 characters in the password field" do
    user = User.new(:login => 'abcde', :password => 'abcd')
    user.should_not be_valid
    user.password = 'abcde'
    user.should be_valid
  end
 
end
