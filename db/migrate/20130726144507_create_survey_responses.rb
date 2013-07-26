class CreateSurveyResponses < ActiveRecord::Migration
  def change
    create_table :survey_responses do |t|
      t.references :survey
      t.hstore :survey_responses

      t.timestamps
    end
    add_index :survey_responses, :survey_id
  end
end
