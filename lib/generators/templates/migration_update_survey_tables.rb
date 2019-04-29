# frozen_string_literal: true

MIGRATION_CLASS =
  if ActiveRecord::VERSION::MAJOR >= 5
    ActiveRecord::Migration["#{ActiveRecord::VERSION::MAJOR}.#{ActiveRecord::VERSION::MINOR}"]
  else
    ActiveRecord::Migration
  end

class UpdateSurveyTables < MIGRATION_CLASS
  def change
    add_column :survey_surveys, :locale_name, :string
    add_column :survey_surveys, :locale_description, :text

    add_column :survey_sections, :locale_head_number, :string
    add_column :survey_sections, :locale_name, :string
    add_column :survey_sections, :locale_description, :text

    add_column :survey_questions, :head_number, :string
    add_column :survey_questions, :description, :text
    add_column :survey_questions, :locale_text, :string
    add_column :survey_questions, :locale_head_number, :string
    add_column :survey_questions, :locale_description, :text

    add_column :survey_options, :locale_text, :string
  end
end
