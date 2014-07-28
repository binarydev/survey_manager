class Question < ActiveRecord::Base
  belongs_to :question_type
  belongs_to :survey
  attr_accessible :question_text, :survey_id, :question_type_id, :order_num, :required_field, :is_email, :confirmation_for_question_id
  validates_presence_of :survey_id
  validates_presence_of :question_type_id
  validates_presence_of :question_text
  
  belongs_to 	:confirmation_for_question,
          		:foreign_key => "confirmation_for_question_id",
          		:class_name => "Question"
  
  has_many :answer_options
  
  default_scope :order => :order_num

  def form_field_input_name
    "survey_responses_#{self.id.to_s}"
  end
  
end
