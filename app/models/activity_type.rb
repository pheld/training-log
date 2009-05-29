class ActivityType < ActiveRecord::Base
  has_many :activities

  named_scope :by_name, :order => 'name ASC'

  # will-paginate
  def self.per_page
    5
  end
end
