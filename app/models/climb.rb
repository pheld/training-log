class Climb < ActiveRecord::Base
  belongs_to :user
  belongs_to :activity

  # will-paginate
  def self.per_page
    5
  end
end
