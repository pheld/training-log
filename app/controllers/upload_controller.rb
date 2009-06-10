class UploadController < ApplicationController

  def index
    render :file => 'app/views/upload/uploadfile.rhtml'
  end

  def processActivitiesFile
    begin
      added = DataFile.processActivities(params[:upload], current_user.id)
      render :text => "added #{added.to_s} activities"
    rescue Exception => e
      render :text => "Error processing file: #{e.message}"
    end
  end

  def processFitnessSamplesFile
    begin
      added = DataFile.processFitnessSamples(params[:upload], current_user.id)
      render :text => "added #{added.to_s} fitness samples"
    rescue Exception => e
      render :text => "Error processing file: #{e.message}"
    end
  end

end
