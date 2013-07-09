class CreateQuestionTypes < ActiveRecord::Migration
  def change
    create_table :question_types do |t|
      t.string :type_name
      t.boolean :has_options

      t.timestamps
    end
  end
end
