class FitnessSample < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :date, :weight_pounds, :body_fat_percentage

  # will-paginate
  def self.per_page
    5
  end
end
