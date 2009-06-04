# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  helper_method :current_user

  protected
   
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

  def InitR
    @r = RSRuby.instance
    return @r
  end
end
