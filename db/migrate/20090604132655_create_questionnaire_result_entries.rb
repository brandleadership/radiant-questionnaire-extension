class CreateQuestionnaireResultEntries < ActiveRecord::Migration
  def self.up
    create_table :questionnaire_result_entries do |t|
      t.integer :questionnaire_result_id
      t.integer :questionnaire_question_id
      t.integer :questionnaire_answer_id
      t.text :freetext_answer
      t.integer :rating_answer

      t.timestamps
    end
  end

  def self.down
    drop_table :questionnaire_result_entries
  end
end
