class ActivitiesController < ApplicationController
  # GET /activities
  # GET /activities.xml
  def index
    @activities = Activity.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @activities }
    end
  end

  # GET /activities/1
  # GET /activities/1.xml
  def show
    @activity = Activity.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @activity }
    end
  end

  def user_activity_hours
    starting_date = Date.today - 1.year

    @activities =
        Activity.find_by_sql("SELECT date, duration_hours FROM activities WHERE user_id=#{params[:id]} AND date > '#{starting_date.to_formatted_s}' ORDER BY date ASC")


    @activity_hours = @activities.map { |a|
      {
          :year => a.date.year,
          :month => a.date.month - 1,
          :month_day => a.date.mday,
          :hours => a.duration_hours
      }
    }

    respond_to do |format|
      format.json { render :json => @activity_hours.to_json }
    end
  end

  def user_activity_weekly_hour_totals
    starting_date = Date.today - 1.year

    @activities =
        Activity.find_by_sql("SELECT date, duration_hours FROM activities WHERE user_id=#{params[:id]} AND date > '#{starting_date.to_formatted_s}' ORDER BY date ASC")

    @week_hour_totals_hash = {}

    @activities.each do |activity|
      week_end_date = activity.date + (7 - activity.date.wday).days

      if @week_hour_totals_hash[week_end_date] == nil
        @week_hour_totals_hash[week_end_date] = activity.duration_hours
      else
        @week_hour_totals_hash[week_end_date] = @week_hour_totals_hash[week_end_date] +
            activity.duration_hours
      end
    end

    @activity_weekly_hour_totals = []

    @week_hour_totals_hash.keys.each do |key|
      @activity_weekly_hour_totals << {
          :year => key.year,
          :month => key.month - 1,
          :month_day => key.mday,
          :hours => @week_hour_totals_hash[key],
          :date_string => key.inspect
      }
    end

    respond_to do |format|
      format.json { render :json => @activity_weekly_hour_totals.to_json }
    end

  end

  # GET /activities/new
  # GET /activities/new.xml
  def new
    @activity_types = ActivityType.find(:all)

    @activity = Activity.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @activity }
    end
  end

  # GET /activities/1/edit
  def edit
    @activity_types = ActivityType.find(:all)
    @activity = Activity.find(params[:id])
  end

  # POST /activities
  # POST /activities.xml
  def create
    @activity_types = ActivityType.find(:all)
    @activity = Activity.new(params[:activity])
    @activity.user_id = current_user.id

    respond_to do |format|
      if @activity.save
        flash[:notice] = 'Activity was successfully created.'
        format.html { redirect_to(:controller => 'index', :action => 'index') }
        format.xml  { render :xml => @activity, :status => :created, :location => @activity }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @activity.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /activities/1
  # PUT /activities/1.xml
  def update
    @activity = Activity.find(params[:id])

    respond_to do |format|
      if @activity.update_attributes(params[:activity])
        flash[:notice] = 'Activity was successfully updated.'
        format.html { redirect_to(@activity) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @activity.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /activities/1
  # DELETE /activities/1.xml
  def destroy
    @activity = Activity.find(params[:id])
    @activity.destroy

    respond_to do |format|
      format.html { redirect_to(:controller => 'index', :action => 'index') }
      format.xml  { head :ok }
    end
  end
end
