class QuestionnaireResultEntry < ActiveRecord::Base
  belongs_to :questionnaire_results
  belongs_to :questionnaire_question

end
