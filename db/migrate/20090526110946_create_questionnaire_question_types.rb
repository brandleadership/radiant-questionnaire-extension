class CreateQuestionnaireQuestionTypes < ActiveRecord::Migration
  def self.up
    create_table :questionnaire_question_types do |t|
      t.string :name

      t.timestamps
    end
    QuestionnaireQuestionType.create :name => 'Freetext'
    QuestionnaireQuestionType.create :name => 'Single-answer'
    QuestionnaireQuestionType.create :name => 'Multiple-answer'
    QuestionnaireQuestionType.create :name => 'Rating'
  end

  def self.down
    drop_table :questionnaire_question_types
  end
end
