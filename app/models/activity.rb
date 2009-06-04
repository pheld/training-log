class Activity < ActiveRecord::Base
  belongs_to :user
  belongs_to :activity_type

  named_scope :by_date, :order => 'date DESC'

  validates_presence_of :description, :user_id, :activity_type_id, :date, :duration_hours 
  validates_numericality_of :duration_hours, :greater_than_or_equal_to => 0
  validates_numericality_of :distance_miles, :greater_than_or_equal_to => 0

  # will-paginate
  def self.per_page
    5
  end
end
