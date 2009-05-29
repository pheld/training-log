class IndexController < ApplicationController

  def index
    if logged_in?
      # load stuff for the overview
#      @activities = Activity.find(:all, :order => 'date DESC')      
      @activities = Activity.paginate :page => params[:activity_page], :per_page => 5, :order => 'date DESC'

      @fitness_samples = FitnessSample.paginate :page => params[:fs_page], :per_page => 5, :order => 'date DESC'


      @climbs = Climb.paginate :page => params[:climb_page], :per_page => 5, :order => 'id DESC'

      render :template => 'index/index'
    else
      redirect_to :controller => 'index', :action => 'login' and return true
    end
  end

  def login
    if !params[:login].nil? && !params[:password].nil? && session[:errprs].nil?
      self.current_user = User.authenticate(params[:login], params[:password])

      unless logged_in?
        flash[:notice] = "Incorrect login or password."
        return
      end

      session[:user_id] = self.current_user.id
    end

    if logged_in?
      flash[:notice] = "Logged in successfully."

      redirect_to :controller => 'index', :action => 'index' and return true
    else
      render :template => 'index/login'
    end
  end

  def logout
    reset_session

    redirect_to :controller => 'index', :action => 'index' and return true
  end
end
