class Question < ActiveRecord::Base
  belongs_to :question_type
  belongs_to :survey
  attr_accessible :question_text
  
  has_many :answer_options
end
