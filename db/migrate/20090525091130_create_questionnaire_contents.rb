class CreateQuestionnaireContents < ActiveRecord::Migration
  def self.up
    create_table :questionnaire_contents do |t|
      t.integer :questionnaire_id
      t.string :language, :limit => 2
      t.string :title, :unique => true
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :questionnaire_contents
  end
end
