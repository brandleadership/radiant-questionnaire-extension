class AddOptionalAndCommentToQuestionnaireQuestions < ActiveRecord::Migration
  def self.up
    add_column :questionnaire_questions, :optional, :boolean
    add_column :questionnaire_questions, :comment, :boolean
  end

  def self.down
    remove_column :questionnaire_results, :optional
    remove_column :questionnaire_results, :comment
  end
end
