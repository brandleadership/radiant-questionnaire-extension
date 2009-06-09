class QuestionnaireAnswer < ActiveRecord::Base
  belongs_to :questionnaire_question

  cattr_accessor :new_data_id
  cattr_accessor :should_destroy

  def should_destroy?
    should_destroy.to_i == 1
  end
end
