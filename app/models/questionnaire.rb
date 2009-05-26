class Questionnaire < ActiveRecord::Base
  has_many :questionnaire_contents

  def questionnaire_contents_attributes=(questionnaire_contents_attributes)
    questionnaire_contents_attributes.each do |attributes|
      questionnaire_contents.build(attributes)
    end
  end

end
