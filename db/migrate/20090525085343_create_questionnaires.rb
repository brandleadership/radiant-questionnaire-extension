class CreateQuestionnaires < ActiveRecord::Migration
  def self.up
    create_table :questionnaires do |t|
      t.datetime :startdate
      t.datetime :enddate
      t.boolean :anonymous

      t.timestamps
    end
  end

  def self.down
    drop_table :questionnaires
  end
end
