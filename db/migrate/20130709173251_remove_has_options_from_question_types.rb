class RemoveHasOptionsFromQuestionTypes < ActiveRecord::Migration
  def up
    remove_column :question_types, :has_options
  end

  def down
    add_column :question_types, :has_options, :bool
  end
end
