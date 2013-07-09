class AnswerOption < ActiveRecord::Base
  belongs_to :question
  attr_accessible :option_text, :question_id
end
