class AddPrereqToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :prereq_answer_option_id, :integer
  end
end
