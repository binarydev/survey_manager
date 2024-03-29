class Survey < ActiveRecord::Base
  attr_accessible :survey_name, :thankyou_text, :intro_text
  has_many :questions
  has_many :survey_responses
  validates_uniqueness_of :survey_name
  validates_presence_of :survey_name
end
