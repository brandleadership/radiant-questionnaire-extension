class QuestionnaireAnswer < ActiveRecord::Base
  belongs_to :questionnaire_questions

  cattr_accessor :new_data_id
end
