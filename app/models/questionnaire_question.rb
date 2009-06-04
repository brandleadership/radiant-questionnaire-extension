class QuestionnaireQuestion < ActiveRecord::Base
  belongs_to :questionnaire_content
  belongs_to :questionnaire_question_type
  has_many :questionnaire_answers
 
  cattr_accessor :new_data_id
end
