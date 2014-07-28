class AddConfirmationForFieldToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :confirmation_for_question_id, :integer
  end
end
