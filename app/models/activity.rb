class Activity < ActiveRecord::Base
  belongs_to :user
  belongs_to :activity_type

  named_scope :by_date, :order => 'date DESC'

  # will-paginate
  def self.per_page
    5
  end
end
