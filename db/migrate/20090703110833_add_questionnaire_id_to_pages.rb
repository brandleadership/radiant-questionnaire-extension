class AddQuestionnaireIdToPages < ActiveRecord::Migration
  def self.up
    add_column :pages, :questionnaire_id, :integer
  end

  def self.down
    remove_column :pages, :questionnaire_id
  end
end
