class AddMasterQuestionIdToQuestion < ActiveRecord::Migration
  def self.up
    add_column :questionnaire_questions, :questionnaire_master_question_id, :integer


    Questionnaire.find(:all).each do |questionnaire|
      master_content = nil
      questionnaire.questionnaire_contents.each do |content|
        if content == questionnaire.questionnaire_contents.first
          master_content = content
        else
           element_counter = 0
           master_content.questionnaire_questions.each do |master_question|
             question = content.questionnaire_questions[element_counter]
             QuestionnaireQuestion.update(question.id, :questionnaire_master_question_id => master_question.id)
             element_counter += 1
           end
        end
      end
    end
    
  end

  def self.down
    remove_column :questionnaire_questions, :questionnaire_master_question_id
  end
end
