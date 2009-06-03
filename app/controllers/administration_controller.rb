class AdministrationController < ApplicationController

  def index
    if logged_in?
      if current_user.is_admin?
        @users = User.paginate :page => params[:user_page], :per_page => User.per_page, :order => 'login ASC'
        @activity_types = ActivityType.paginate :page => params[:at_page], :per_page => ActivityType.per_page, :order => 'name ASC'

        render :template => 'administration/index'
      else
        redirect_to :controller => 'index', :action => 'index' and return true
      end
    else
      redirect_to :controller => 'index', :action => 'login' and return true
    end
  end  

end
