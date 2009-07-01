class AddCommentToQuestionnaireResultEntries < ActiveRecord::Migration
  def self.up
    add_column :questionnaire_result_entries, :comment, :text
  end

  def self.down
    remove_column :questionnaire_result_entries, :comment
  end
end
