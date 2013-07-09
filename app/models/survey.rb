class Survey < ActiveRecord::Base
  attr_accessible :survey_name
  has_many :questions
  validates_uniqueness_of :survey_name
end
