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

  before_save :check_order_num
  
  default_scope :order => :order_num

  def form_field_input_name
    if(self.question_type.type_name == 'Multi-Option')
      "survey_responses[#{self.id.to_s}][]"
    else
      "survey_responses[#{self.id.to_s}]"
    end
    
  end

  def form_field_id_name
    "survey_responses_#{self.id.to_s}"
  end

  def check_order_num
    if self.order_num.nil?
      self.order_num = self.survey.questions.count
    end

  end
  
end
