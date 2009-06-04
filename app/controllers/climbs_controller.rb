class ClimbsController < ApplicationController
  # GET /climbs
  # GET /climbs.xml
  def index
    @climbs = Climb.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @climbs }
    end
  end

  # GET /climbs/1
  # GET /climbs/1.xml
  def show
    @climb = Climb.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @climb }
    end
  end

  # GET /climbs/new
  # GET /climbs/new.xml
  def new
    @activities = Activity.find_all_by_user_id(current_user.id, 'date DESC')

    @climb = Climb.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @climb }
    end
  end

  # GET /climbs/1/edit
  def edit
    @activities = Activity.find(:all, :order => 'date DESC')

    @climb = Climb.find(params[:id])
  end

  # POST /climbs
  # POST /climbs.xml
  def create
    @activities = Activity.find_all_by_user_id(current_user.id, 'date DESC')
    @climb = Climb.new(params[:climb])

    respond_to do |format|
      if @climb.save
        flash[:notice] = 'Climb was successfully created.'
        format.html { redirect_to(:controller => 'index', :action => 'index') }
        format.xml  { render :xml => @climb, :status => :created, :location => @climb }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @climb.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /climbs/1
  # PUT /climbs/1.xml
  def update
    @climb = Climb.find(params[:id])

    respond_to do |format|
      if @climb.update_attributes(params[:climb])
        flash[:notice] = 'Climb was successfully updated.'
        format.html { redirect_to(@climb) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @climb.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /climbs/1
  # DELETE /climbs/1.xml
  def destroy
    @climb = Climb.find(params[:id])
    @climb.destroy

    respond_to do |format|
      format.html { redirect_to(:controller => 'index', :action => 'index') }
      format.xml  { head :ok }
    end
  end
end
