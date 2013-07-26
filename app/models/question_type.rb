class QuestionType < ActiveRecord::Base
  has_many :questions
  attr_accessible :has_options, :type_name
  
  delegate :single_option?, :multi_option?, :ranking?, :short_text?, :open_ended_text?, :to => :question_type_name
  
  def question_type_name
    self.type_name.gsub(/ /,'_').downcase.inquiry
  end
  
end
