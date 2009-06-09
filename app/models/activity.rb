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

  def self.first_date_by_user(user_id)
    first = self.find(:first, :conditions => "user_id = #{user_id.to_s}", :order => "date ASC")
    first.date
  end

  def self.last_date_by_user(user_id)
    last = self.find(:last, :conditions => "user_id = #{user_id.to_s}", :order => "date ASC")
    last.date
  end
end
