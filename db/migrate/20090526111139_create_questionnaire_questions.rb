class CreateQuestionnaireQuestions < ActiveRecord::Migration
  def self.up
    create_table :questionnaire_questions do |t|
      t.integer :questionnaire_content_id
      t.integer :questionnaire_question_type_id
      t.text :question

      t.timestamps
    end
  end

  def self.down
    drop_table :questionnaire_questions
  end
end
