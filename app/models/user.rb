class User < ActiveRecord::Base
  has_many :activities
  has_many :fitness_samples
  has_many :climbs

  named_scope :by_login, :order => 'login ASC'

  def self.authenticate(login, password)
    user = find :first, :conditions => { :login => login }
    user && ( user.password = password ) ? user : nil
  end
end
