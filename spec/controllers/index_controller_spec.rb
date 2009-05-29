require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe IndexController do
  fixtures :users, :activities, :fitness_samples, :climbs

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

      User.stub!(:authenticate).and_return(mock_user)
    end

    it "should login a valid user" do
      post_login(mock_user)
      flash[:notice].should_not be_nil
      flash[:notice].should eql("Logged in successfully.")
      response.should redirect_to(:controller => 'index', :action => 'index')
    end

    it "should not login an invalid user" do
      User.stub!(:authenticate).and_return(nil)
      post_login(mock_user)
      flash[:notice].should_not be_nil
      flash[:notice].should eql("Incorrect login or password.")
      response.should render_template('index/login')
    end

  end

  describe 'Logout testing' do

    it "should redirect logged out user to the login page" do
      post :logout
      response.should redirect_to(:controller => 'index', :action => 'index')
    end

  end

  describe 'Home (overview) page testing' do

    before(:each) do
      mock_user(:login => 'pheld', :password => 'passw0rd!')

      User.stub!(:authenticate).and_return(mock_user)

      post_login(mock_user)
    end

    it "should fetch activities" do
      get :index

#      assigns(:activities).should be_an_instance_of(Array)
      assigns(:activities).should_not be_empty
    end

    it "should fetch fitness samples" do
      get :index

      assigns(:fitness_samples).should_not be_empty
    end 

    it "should fetch climbs" do
      get :index

      assigns(:climbs).should_not be_empty
    end

  end

end
