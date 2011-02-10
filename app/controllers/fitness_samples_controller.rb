class FitnessSamplesController < ApplicationController
  # GET /fitness_samples
  # GET /fitness_samples.xml
  def index
    @fitness_samples = FitnessSample.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @fitness_samples }
    end
  end

  # GET /fitness_samples/1
  # GET /fitness_samples/1.xml
  def show
    @fitness_sample = FitnessSample.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @fitness_sample }
    end
  end

  def user_samples
    starting_date = Date.today - 1.year

    @fitness_samples =
        FitnessSample.find_by_sql("SELECT date, weight_pounds, body_fat_percentage FROM fitness_samples WHERE user_id=#{params[:id]} AND date > '#{starting_date.to_formatted_s}' ORDER BY date ASC")


    @fitness_sample_summaries = @fitness_samples.map { |fs|
      {
          :year => fs.date.year,
          :month => fs.date.month - 1,
          :month_day => fs.date.mday,
          :weight_pounds => fs.weight_pounds,
          :body_fat_percentage => fs.body_fat_percentage
      }
    }

    respond_to do |format|
      format.json { render :json => @fitness_sample_summaries.to_json }
    end
  end

  def user_samples_rolling_average
    samples = params[:samples] || 7

    starting_date = Date.today - 1.year

    @fitness_samples =
        FitnessSample.find_by_sql("SELECT date, weight_pounds, body_fat_percentage FROM fitness_samples WHERE user_id=#{params[:id]} AND date > '#{starting_date.to_formatted_s}' ORDER BY date ASC")

    @fitness_sample_averages = []

    if @fitness_samples.size >= samples
      (samples - 1).upto(@fitness_samples.size - 1) do |i|
        sample = @fitness_samples[i]

        weight_sum = 0
        body_fat_sum = 0

        (i - samples - 1).upto(i) do |j|
          weight_sum = weight_sum + @fitness_samples[j].weight_pounds
          body_fat_sum = body_fat_sum + @fitness_samples[j].body_fat_percentage
        end

        @fitness_sample_averages << {
            :date => sample.date,
            :weight_average => weight_sum / samples,
            :body_fat_percentage_average => body_fat_sum / samples
        }
      end
    end

    @fitness_sample_summaries = @fitness_sample_averages.each { |fsa|
      {
          :year => fsa[:date].year,
          :month => fsa[:date].month - 1,
          :month_day => fsa[:date].mday,
          :weight_pounds => fsa[:weight_average],
          :body_fat_percentage => fsa[:body_fat_percentage_average]
      }
    }

    respond_to do |format|
      format.json { render :json => @fitness_sample_summaries.to_json }
    end
  end

  # GET /fitness_samples/new
  # GET /fitness_samples/new.xml
  def new
    @fitness_sample = FitnessSample.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @fitness_sample }
    end
  end

  # GET /fitness_samples/1/edit
  def edit
    @fitness_sample = FitnessSample.find(params[:id])
  end

  # POST /fitness_samples
  # POST /fitness_samples.xml
  def create
    @fitness_sample = FitnessSample.new(params[:fitness_sample])
    @fitness_sample.user_id = current_user.id

    respond_to do |format|
      if @fitness_sample.save
        flash[:notice] = 'FitnessSample was successfully created.'
        format.html { redirect_to(:controller => 'index', :action => 'index') }
        format.xml  { render :xml => @fitness_sample, :status => :created, :location => @fitness_sample }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @fitness_sample.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /fitness_samples/1
  # PUT /fitness_samples/1.xml
  def update
    @fitness_sample = FitnessSample.find(params[:id])

    respond_to do |format|
      if @fitness_sample.update_attributes(params[:fitness_sample])
        flash[:notice] = 'FitnessSample was successfully updated.'
        format.html { redirect_to(@fitness_sample) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @fitness_sample.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /fitness_samples/1
  # DELETE /fitness_samples/1.xml
  def destroy
    @fitness_sample = FitnessSample.find(params[:id])
    @fitness_sample.destroy

    respond_to do |format|
      format.html { redirect_to(:controller => 'index', :action => 'index') }
      format.xml  { head :ok }
    end
  end
end
