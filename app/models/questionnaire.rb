class Questionnaire < ActiveRecord::Base

  has_many :questionnaire_contents, :dependent => :destroy
  has_many :questionnaire_results
  after_update :save_questionnaire_contents

  def questionnaire_contents_attributes=(questionnaire_contents_attributes)
    questionnaire_contents_attributes.each do |attributes|
      if attributes[:id].blank?
        content = questionnaire_contents.build(attributes)
        content.save()
        @new_content_id = content.id
      else
        content = questionnaire_contents.detect { |q| q.id == attributes[:id].to_i }
        content.attributes = attributes
      end
    end
  end

  def questionnaire_questions_attributes=(questionnaire_questions_attributes)
    @question_ids = {}
    questionnaire_questions_attributes.each do |attributes|
       if attributes[:questionnaire_content_id].blank?
         attributes[:questionnaire_content_id] = @new_content_id
       end
       content = questionnaire_contents.detect { |q| q.id == attributes[:questionnaire_content_id].to_i }

       if attributes[:id].blank?
         question = content.questionnaire_questions.build(attributes)
         question.save();
         @question_ids[attributes[:new_data_id]] = question.id
       else
         question = content.questionnaire_questions.detect { |q| q.id == attributes[:id].to_i }
         question.attributes = attributes

         if question.should_destroy?
           question.destroy
         else
           question.save
         end

       end
    end
  end

  def questionnaire_answer_attributes=(questionnaire_answer_attributes)
    questionnaire_answer_attributes.each do |attributes|

      if attributes[:questionnaire_question_id].blank?
       attributes[:questionnaire_question_id] = @question_ids[attributes[:new_data_id]]
      end
      question = QuestionnaireQuestion.find_by_id(attributes[:questionnaire_question_id]);

      if attributes[:id].blank?
        answer = question.questionnaire_answers.build(attributes)
        answer.save()
      else
        #check if question is already deleted
        unless question == nil
          answer = question.questionnaire_answers.detect { |q| q.id == attributes[:id].to_i }
          answer.attributes = attributes

          if answer.should_destroy?
            answer.destroy
          else
            answer.save
          end
        end
      end
    end
  end

  def save_questionnaire_contents
    questionnaire_contents.each do |q|
      q.save(false)
    end
  end

  def copy
    questionnaire_copy = Questionnaire.new
    attributes.each {|attr, value| eval("questionnaire_copy.#{attr}= #{attr}")}
    questionnaire_copy.id = nil
    questionnaire_copy.created_at = nil
    questionnaire_copy.updated_at = nil
    questionnaire_copy.save
    questionnaire_copy
  end

  def copy_with_children
    questionnaire_new = copy
    questionnaire_contents.each do |content|
      content.copy_with_children(questionnaire_new)
    end
    questionnaire_new
  end
end
