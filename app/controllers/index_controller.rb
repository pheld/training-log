class IndexController < ApplicationController

  def index
    if logged_in?
      # load stuff for the overview
      
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

  def graphy
    # make some data
    data_sets = []
    data_set = {:title => "Wowee Wowzsers", :data_points => [[1,14], [2,7], [3,19], [4,22], [5,8]]}
    data_sets << data_set
    data_set_2 = {:title => "Bowzer FRowsers", :data_points => [[1,4], [2,19], [3,22], [4,3], [5,30]]}
    data_sets << data_set_2

    ghelper = GraphHelper.new

    graph = ghelper.generate_graph(data_sets)

    # WILL this work?  Really?  Rails will just DO this?
    send_data(graph.to_blob, :disposition => 'inline', :type => 'image/png', :filename => 'arbitraryfilename.png')
  end

end
