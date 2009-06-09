class UploadController < ApplicationController

  def index
    render :file => 'app/views/upload/uploadfile.rhtml'
  end

  def processActivitiesFile
#    begin
      added = DataFile.processActivities(params[:upload], current_user.id)
      render :text => "added #{added.to_s} activities"
#    rescue Exception => e
#      render :text => "Error processing file: #{e.message}"
#    end
  end

  def processFitnessSamplesFile
    post = DataFile.processFitnessSamples(params[:upload])
    render :text => post[1].to_s
  end

end
