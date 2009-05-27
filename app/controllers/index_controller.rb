class IndexController < ApplicationController

  def login
    if !params[:login].nil? && !params[:password].nil? && session[:errprs].nil?
      self.current_user = User.authenticate(params[:login], params[:password])

      unless logged_in?
        flash[:notice] = "Incorrect login or password."
        return
      end
    end

    if logged_in?
      flash[:notice] = "Logged in successfully."

      redirect_to :controller => 'index', :action => 'index' and return true
    else
      render :template => 'index/login'
    end
  end

  def logout
    reset_session
  end
end
