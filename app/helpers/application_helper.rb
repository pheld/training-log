# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  # set R_HOME if not set
  if ENV['R_HOME'].nil?
    ENV['R_HOME'] = "/Library/Frameworks/R.framework/Resources"
  end
end
