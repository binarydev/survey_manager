class AddRequiredToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :required_field, :boolean, default: true
  end
end
