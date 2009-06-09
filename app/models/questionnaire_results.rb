class QuestionnaireResults < ActiveRecord::Base

  has_many :questionnaire_result_entries

  validates_presence_of :firstname, :lastname, :email

  after_save :save_questionnaire_results

  def questionnaire_result_entries_attributes=(questionnaire_result_entries_attributes)
    questionnaire_result_entries_attributes.each do |attributes|
      if (!attributes[:questionnaire_answer_id].blank? or
              !attributes[:freetext_answer].blank? or 
              !attributes[:rating_answer].blank?)
        attributes[:questionnaire_result_id] = id
        questionnaire_result_entries.build(attributes)
      end 
    end
  end

  def save_questionnaire_results
    questionnaire_result_entries.each do |q|
      q.questionnaire_result_id = id
      q.save(false)
    end
  end
end