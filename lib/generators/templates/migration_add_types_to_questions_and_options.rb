# frozen_string_literal: true

MIGRATION_CLASS =
  if ActiveRecord::VERSION::MAJOR >= 5
    ActiveRecord::Migration["#{ActiveRecord::VERSION::MAJOR}.#{ActiveRecord::VERSION::MINOR}"]
  else
    ActiveRecord::Migration
  end

class AddTypesToQuestionsAndOptions < MIGRATION_CLASS
  def change
    add_column :survey_questions, :questions_type_id, :integer

    add_column :survey_options, :options_type_id, :integer

    add_column :survey_answers, :option_text, :text
    add_column :survey_answers, :option_number, :integer
  end
end
