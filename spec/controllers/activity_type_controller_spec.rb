require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ActivityTypesController do
  fixtures :users

  before(:each) do
    # pretend to be logged in
    ApplicationController.stub!(:logged_in?).and_return(mock_user)
  end

  def mock_user(stubs = {})
    @user ||= mock_model(User, stubs).as_null_object
  end

  def mock_activity_type(stubs = {})
    @activity_type ||= mock_model(ActivityType, stubs).as_null_object
  end

 describe 'ActivityType creation testing' do
    
    it "should forward to the administration page after creating a new activity type" do
      post :create, :activity_type => {:name => 'test_activity_type', :description => 'fake description'}
      response.should redirect_to(:controller => 'administration', :action => 'index')
    end

  end

end
