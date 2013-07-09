class CreateAnswerOptions < ActiveRecord::Migration
  def change
    create_table :answer_options do |t|
      t.string :option_text
      t.references :question

      t.timestamps
    end
    add_index :answer_options, :question_id
  end
end
