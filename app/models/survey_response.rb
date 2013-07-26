class SurveyResponse < ActiveRecord::Base
  belongs_to :survey
  attr_accessible :survey_responses, :survey_id
  serialize :survey_responses, ActiveRecord::Coders::Hstore
  validates_presence_of :survey_id
end
