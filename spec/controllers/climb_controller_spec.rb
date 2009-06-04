require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ClimbsController do
  fixtures :users, :activity_types, :activities
  
  before(:each) do
    # pretend to be logged in
    ApplicationController.stub!(:logged_in?).and_return(true)
    controller.stub!(:current_user).and_return(users(:pheld))
  end

  def mock_user(stubs = {})
    @user ||= mock_model(User, stubs).as_null_object
  end

 describe 'Climb creation testing' do
    
    it "should forward to the home page after creating a new climb" do
      post :create, :climb => {:activity_id => activities(:mercer_island).id, :description => 'test_climb', :duration_seconds => 2250, :altitude_gained_feet => 1860, :weight_pounds => 168, :weight_of_equipment_pounds => 25}
      response.should redirect_to(:controller => 'index', :action => 'index')
    end

  end

end
