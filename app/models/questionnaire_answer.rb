class QuestionnaireAnswer < ActiveRecord::Base
  belongs_to :questionnaire_question

  cattr_accessor :new_data_id
  cattr_accessor :should_destroy

  def should_destroy?
    should_destroy.to_i == 1
  end

  def copy(question_new)
    answer_copy = QuestionnaireAnswer.new
    attributes.each {|attr, value| eval("answer_copy.#{attr}= #{attr}")}
    answer_copy.id = nil
    answer_copy.questionnaire_question_id = question_new.id
    answer_copy.created_at = nil
    answer_copy.updated_at = nil
    answer_copy.save
    answer_copy
  end
end
