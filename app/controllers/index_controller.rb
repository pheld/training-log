class IndexController < ApplicationController

  def index
    if logged_in?
      # get activities associated with the current user
      @activities = Activity.paginate_by_user_id current_user.id, :page => params[:activity_page], :per_page => Activity.per_page, :order => 'date DESC'

      # fitness samples associated with the current user
      @fitness_samples = FitnessSample.paginate_by_user_id current_user.id, :page => params[:fs_page], :per_page => FitnessSample.per_page, :order => 'date DESC'

      # get the climbs associated with activities associated with the current user
      @climbs = Climb.paginate_by_sql "SELECT c.* FROM climbs c, users u, activities a WHERE u.id = #{current_user.id.to_s} AND u.id = a.user_id AND a.id = c.activity_id ORDER BY a.date DESC", :page => params[:climb_page], :per_page => Climb.per_page

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
