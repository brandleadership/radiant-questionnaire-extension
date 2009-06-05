class QuestionnaireResults < ActiveRecord::Base

  has_many :questionnaire_result_entries

  validates_presence_of :firstname, :lastname, :email

  def questionnaire_result_entries_attributes=(questionnaire_result_entries_attributes)
    questionnaire_result_entries_attributes.each do |attributes|
      if (!attributes[:questionnaire_answer_id].blank? or
              !attributes[:freetext_answer].blank? or 
              !attributes[:rating_answer].blank?)
        questionnaire_result_entries.build(attributes)
      end 
    end
  end

end
