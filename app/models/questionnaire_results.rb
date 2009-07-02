class QuestionnaireResults < ActiveRecord::Base

  has_many :questionnaire_result_entries

  validates_presence_of :firstname, :lastname, :email

  after_save :save_questionnaire_results

  def questionnaire_result_entries_attributes=(questionnaire_result_entries_attributes)
    questionnaire_result_entries_attributes.each do |attributes|
      corrected_attirubes = {}
      attributes.each do |key, value|
        if key.index('questionnaire_answer_id__') != nil
          key_new = 'questionnaire_answer_id'
        else
          if key.index('rating_answer__') != nil
            key_new = 'rating_answer'
          else
            key_new = key
          end 
        end
        corrected_attirubes.merge!({key_new => value })
      end

      if !corrected_attirubes['questionnaire_answer_id'].blank? or !corrected_attirubes['freetext_answer'].blank? or !corrected_attirubes['rating_answer'].blank? or !corrected_attirubes['comment'].blank?
        corrected_attirubes[:questionnaire_result_id] = id
        questionnaire_result_entries.build(corrected_attirubes)
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
