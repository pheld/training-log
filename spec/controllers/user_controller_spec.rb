require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe UsersController do
  fixtures :users

  before(:each) do
    # pretend to be logged in
    ApplicationController.stub!(:logged_in?).and_return(true)
  end

  def mock_user(stubs = {})
    @user ||= mock_model(User, stubs).as_null_object
  end

 describe 'User creation testing' do
    
    it "should forward to the administration page after creating a new user" do
      post :create, :user => {:login => 'test_user_login', :password => 'passw0rd!', :is_admin => 0}
      response.should redirect_to(:controller => 'administration', :action => 'index')
    end

  end

end
