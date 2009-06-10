class UploadController < ApplicationController

  def index
    render :template => 'upload/uploadfile'
  end

  def processActivitiesFile
    begin
      added = DataFile.processActivities(params[:upload], current_user.id)
      flash[:message] = "Added #{added.to_s} activities."
      redirect_to :controller => 'index', :action => 'index'
    rescue Exception => e
      render :text => "Error processing file: #{e.message}"
    end
  end

  def processFitnessSamplesFile
    begin
      added = DataFile.processFitnessSamples(params[:upload], current_user.id)
      flash[:message] = "Added #{added.to_s} fitness samples"
      redirect_to :controller => 'index', :action => 'index'
    rescue Exception => e
      render :text => "Error processing file: #{e.message}"
    end
  end

end
