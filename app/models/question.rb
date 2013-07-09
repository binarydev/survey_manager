class Question < ActiveRecord::Base
  belongs_to :question_type
  belongs_to :survey
  attr_accessible :question_text, :survey_id, :question_type_id
  validates_presence_of :survey_id
  validates_presence_of :question_type_id
  validates_presence_of :question_text
  
  has_many :answer_options
end
