class FitnessSample < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :date, :weight_pounds, :body_fat_percentage
  validates_uniqueness_of :date, :scope => :user_id
  validates_numericality_of :weight_pounds, :greater_than_or_equal_to => 0.0
  validates_numericality_of :body_fat_percentage, :greater_than_or_equal_to => 0.0
  validates_numericality_of :body_fat_percentage, :less_than_or_equal_to => 100.0
  validate :must_have_valid_user

  # will-paginate
  def self.per_page
    5
  end

  def must_have_valid_user
    if (self.user_id.nil?)
      errors.add_to_base("Must belong to a valid user")
    else
      errors.add_to_base("Must belong to a valid user") unless !User.find(self.user_id).nil?
    end
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
