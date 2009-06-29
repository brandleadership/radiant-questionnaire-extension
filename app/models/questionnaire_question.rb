class QuestionnaireQuestion < ActiveRecord::Base
  belongs_to :questionnaire_content
  belongs_to :questionnaire_question_type
  has_many :questionnaire_answers, :dependent => :destroy
  has_many :questionnaire_result_entries
 
  cattr_accessor :new_data_id
  cattr_accessor :should_destroy

  def should_destroy?
    should_destroy.to_i == 1
  end
  
  def get_questionnaire_result_entries(questionnaire_result)
    questionnaire_result_entries.select do |q|
      q.questionnaire_result_id == questionnaire_result.id.to_i
    end
  end

  def copy(questionnaire_content_new)
    question_copy = QuestionnaireQuestion.new
    attributes.each {|attr, value| eval("question_copy.#{attr}= #{attr}")}
    question_copy.id = nil
    question_copy.questionnaire_content_id = questionnaire_content_new.id
    question_copy.created_at = nil
    question_copy.updated_at = nil
    question_copy.save
    question_copy
  end

  def copy_with_children(questionnaire_content_new)
    question_new = copy(questionnaire_content_new)
    questionnaire_answers.each do |answer|
       answer.copy(question_new)
     end
  end
end
