class AddOrderToQuestion < ActiveRecord::Migration
  def self.up
    add_column :questionnaire_questions, :order, :integer

    Questionnaire.find(:all).each do |questionnaire|
      questionnaire.questionnaire_contents.each do |content|
        question_counter = 0
        content.questionnaire_questions.each do |question|
          question.order = question_counter
          question.save
          question_counter += 1
        end
      end
    end
    
  end

  def self.down
    remove_column :questionnaire_questions, :questionnaire_order
  end
end
