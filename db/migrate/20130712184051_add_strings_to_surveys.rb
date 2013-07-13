class AddStringsToSurveys < ActiveRecord::Migration
  def change
    add_column :surveys, :intro_text, :text
    add_column :surveys, :thankyou_text, :text
  end
end
