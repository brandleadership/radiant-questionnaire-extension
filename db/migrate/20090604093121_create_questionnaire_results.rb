class CreateQuestionnaireResults < ActiveRecord::Migration
  def self.up
    create_table :questionnaire_results do |t|
      t.string :firstname
      t.string :lastname
      t.string :email
      t.timestamp :submission_date

      t.timestamps
    end
  end

  def self.down
    drop_table :questionnaire_results
  end
end
