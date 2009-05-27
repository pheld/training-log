class User < ActiveRecord::Base
  def self.authenticate(login, password)
    user = find :first, :conditions => { :login => login }
    user && ( user.password = password ) ? user : nil
  end
end
