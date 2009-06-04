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
