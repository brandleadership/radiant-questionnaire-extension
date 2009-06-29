class QuestionnaireContent < ActiveRecord::Base
  belongs_to :questionnaire
  has_many :questionnaire_questions, :dependent => :destroy

  def copy(questionnaire_new)
    content_copy = QuestionnaireContent.new
    attributes.each {|attr, value| eval("content_copy.#{attr}= #{attr}")}
    content_copy.id = nil
    content_copy.questionnaire_id = questionnaire_new.id
    content_copy.created_at = nil
    content_copy.updated_at = nil
    content_copy.save
    content_copy
  end

  def copy_with_children(questionnaire_new)
    content_new = copy(questionnaire_new)
     questionnaire_questions.each do |question|
      question.copy_with_children(content_new)
    end
  end
end
