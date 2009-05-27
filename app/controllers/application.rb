# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => 'e73bc9c275d594f59f0cfaa1b6b162ab'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
  
  def logged_in?
    !!current_user
  end

  def current_user
    @current_user ||= login_from_session unless @current_user == false
  end

  def login_from_session
    self.current_user = User.find_by_id(session[:user_id]) if session[:user_id]
  end

  def set_user
    session[:user] = true
  end

  def current_user=(user)
    session[:user_id] = user ? user.id : nil
    @current_user = user || false
  end
end
