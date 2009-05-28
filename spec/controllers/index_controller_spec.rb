require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe IndexController do
  fixtures :users

  before(:each) do
    # nothing for now
  end

  def mock_user(stubs = {})
    @user ||= mock_model(User, stubs).as_null_object
  end

  def post_login(user, options = {})
    post :login, {:login => user.login, :password => user.password}.merge(options)
  end

  describe 'Login testing' do

    before(:each) do
      mock_user(:login => 'pheld', :password => 'passw0rd!')
    end

    it "should login a valid user" do
      post_login(mock_user)
      flash[:notice].should_not be_nil
      flash[:notice].should eql("Logged in successfully.")
      response.should redirect_to(:controller => 'index', :action => 'index')
    end

  end
end
