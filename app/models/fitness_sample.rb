class FitnessSample < ActiveRecord::Base
  belongs_to :user

  # will-paginate
  def self.per_page
    5
  end
end
