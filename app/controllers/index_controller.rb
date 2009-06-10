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

  def graph_weight
    ghelper = GraphHelper.new

    # get the fitness sample data sets for this user
    @fitness_samples = FitnessSample.find_all_by_user_id current_user.id, :order => 'date ASC'
    if @fitness_samples.length > 0
      weight_data_set = ghelper.fitness_samples_to_weight_data_set(@fitness_samples, first_date, last_date)
      average_weight_data_set = ghelper.fitness_samples_to_seven_day_weight_average_data_set(@fitness_samples, first_date, last_date)
      data_sets = []
      data_sets << average_weight_data_set
      data_sets << weight_data_set

      graph = ghelper.generate_graph(data_sets, first_date, last_date)

      send_data(graph.to_blob, :disposition => 'inline', :type => 'image/png', :filename => 'arbitraryfilename.png')
    else
      send_file('public/images/zubaz-stallion.jpg', :disposition => 'inline', :type => 'image/jpeg')
    end
  end

  def graph_body_fat_percentage
    ghelper = GraphHelper.new

    # get the fitness sample data sets for this user
    @fitness_samples = FitnessSample.find_all_by_user_id current_user.id, :order => 'date ASC'
    if @fitness_samples.length > 0
      bf_percent_data_set = ghelper.fitness_samples_to_body_fat_percentage_data_set(@fitness_samples, first_date, last_date)
      average_bf_percent_data_set = ghelper.fitness_samples_to_seven_day_bfp_average_data_set(@fitness_samples, first_date, last_date)
      data_sets = []
      data_sets << average_bf_percent_data_set
      data_sets << bf_percent_data_set

      graph = ghelper.generate_graph(data_sets, first_date, last_date)

      send_data(graph.to_blob, :disposition => 'inline', :type => 'image/png', :filename => 'arbitraryfilename.png')
    else
      send_file('public/images/zubaz-mesh-mullet.png', :disposition => 'inline', :type => 'image/png')
    end
  end

  def graph_hours
    ghelper = GraphHelper.new

    # get the fitness sample data sets for this user
    @activities = Activity.find_all_by_user_id current_user.id, :order => 'date ASC'
    if @activities.length > 0
      total_hours_data_set = ghelper.activities_to_seven_day_hours_total_data_set(@activities, first_date, last_date)
      data_sets = []
      data_sets << total_hours_data_set

      graph = ghelper.generate_graph(data_sets, first_date, last_date)
      graph.minimum_value = 0

      send_data(graph.to_blob, :disposition => 'inline', :type => 'image/png', :filename => 'arbitraryfilename.png')
    else
      send_file('public/images/zubaz-suit.jpg', :disposition => 'inline', :type => 'image/jpeg')
    end
  end

  protected

  def first_date
    first_a_date = Activity.first_date_by_user(current_user.id)

    if FitnessSample.find_all_by_user_id(current_user.id).length > 0
      first_fs_date = FitnessSample.first_date_by_user(current_user.id)

      first_date = first_a_date <= first_fs_date ? first_a_date : first_fs_date
    else
      first_date = first_a_date
    end
  end

  def last_date
    last_a_date = Activity.last_date_by_user(current_user.id)

    if FitnessSample.find_all_by_user_id(current_user.id).length > 0
      last_fs_date = FitnessSample.last_date_by_user(current_user.id)

      last_date = last_a_date >= last_fs_date ? last_a_date : last_fs_date
    else
      last_date = last_a_date
    end
  end

end
