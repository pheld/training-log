class ActivityType < ActiveRecord::Base
  has_many :activities

  named_scope :by_name, :order => 'name ASC'

  validates_presence_of :name

  # will-paginate
  def self.per_page
   10 
  end
end
