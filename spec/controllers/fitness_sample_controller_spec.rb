require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe FitnessSamplesController do
  fixtures :users
  
  before(:each) do
    # pretend to be logged in
    ApplicationController.stub!(:logged_in?).and_return(true)
    controller.stub!(:current_user).and_return(users(:pheld))
  end

  def mock_user(stubs = {})
    @user ||= mock_model(User, stubs).as_null_object
  end

 describe 'Fitness Sample creation testing' do
    
    it "should forward to the home page after creating a new fitness sample" do
      post :create, :fitness_sample => {:date => '5/1/09', :weight_pounds => 167.5, :body_fat_percentage => 9.5}
      response.should redirect_to(:controller => 'index', :action => 'index')
    end

  end

end
