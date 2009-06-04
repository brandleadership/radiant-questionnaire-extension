class QuestionnaireResults < ActiveRecord::Base

  has_many :questionnaire_result_entries

  validates_presence_of :firstname, :lastname, :email

  def questionnaire_result_entries_attributes=(questionnaire_result_entries_attributes)
    questionnaire_result_entries_attributes.each do |attributes|
      questionnaire_result_entries.build(attributes)
    end
  end

end
