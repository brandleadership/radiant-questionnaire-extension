class QuestionnaireContent < ActiveRecord::Base
  belongs_to :questionnaire
  has_many :questionnaire_questions, :dependent => :destroy

end
