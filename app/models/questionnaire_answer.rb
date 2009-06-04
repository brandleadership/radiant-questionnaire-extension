class QuestionnaireAnswer < ActiveRecord::Base
  belongs_to :questionnaire_question

  cattr_accessor :new_data_id
end
