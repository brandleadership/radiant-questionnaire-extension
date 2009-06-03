class QuestionnaireQuestion < ActiveRecord::Base
  belongs_to :questionnaire_contents
  belongs_to :questionnaire_question_types
  has_many :questionnaire_answers
 
  cattr_accessor :new_data_id
end
