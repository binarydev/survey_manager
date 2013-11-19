class AddIsEmailToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :is_email, :boolean, default: false
  end
end
