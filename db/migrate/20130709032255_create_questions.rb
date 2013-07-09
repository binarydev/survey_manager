class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :question_text
      t.references :question_type
      t.references :survey

      t.timestamps
    end
    add_index :questions, :question_type_id
    add_index :questions, :survey_id
  end
end
