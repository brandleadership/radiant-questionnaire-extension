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
    questionnaire_result_entries.select { |q|
      q.questionnaire_result_id == questionnaire_result.id.to_i
    }
  end
end
