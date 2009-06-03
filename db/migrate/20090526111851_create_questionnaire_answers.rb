class CreateQuestionnaireAnswers < ActiveRecord::Migration
  def self.up
    create_table :questionnaire_answers do |t|
      t.integer :questionnaire_question_id
      t.text :answer

      t.timestamps
    end
  end

  def self.down
    drop_table :questionnaire_answers
  end
end
