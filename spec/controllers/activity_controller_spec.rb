require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ActivitiesController do
  fixtures :users, :activity_types
  
  before(:each) do
    # pretend to be logged in
    ApplicationController.stub!(:logged_in?).and_return(true)
#    ApplicationController.stub!(:current_user).and_return(users(:pheld))
    controller.stub!(:current_user).and_return(users(:pheld))
  end

  def mock_user(stubs = {})
    @user ||= mock_model(User, stubs).as_null_object
  end

  def mock_activity_type(stubs = {})
    @activity_type ||= mock_model(ActivityType, stubs).as_null_object
  end

 describe 'Activity creation testing' do
    
    it "should forward to the home page after creating a new activity" do
#      puts "current user: #{ApplicationController.current_user.login}"
      post :create, :activity => {:activity_type_id => activity_types(:road_cycling).id, :date => '5/1/09', :description => 'test_activity', :duration_hours => 3.4, :distance_miles => 62.2}
      response.should redirect_to(:controller => 'index', :action => 'index')
    end

  end

end
