class QuestionType < ActiveRecord::Base
  has_many :questions
  attr_accessible :has_options, :type_name
end
