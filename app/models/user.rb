class User < ActiveRecord::Base
  has_many :activities, :dependent => :destroy
  has_many :fitness_samples, :dependent => :destroy

  named_scope :by_login, :order => 'login ASC'

  validates_presence_of :password
  validates_length_of :password, :minimum => 5, :message => "Password is too short.  Use at least 5 characters"
  validates_presence_of :login
  validates_length_of :login, :minimum => 5, :message => "Login is too short.  Use at least 5 characters."

  def self.authenticate(login, password)
    user = find :first, :conditions => { :login => login }
    user && ( user.password = password ) ? user : nil
  end

  def self.per_page
    10
  end
end
