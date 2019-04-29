# frozen_string_literal: true

MIGRATION_CLASS =
  if ActiveRecord::VERSION::MAJOR >= 5
    ActiveRecord::Migration["#{ActiveRecord::VERSION::MAJOR}.#{ActiveRecord::VERSION::MINOR}"]
  else
    ActiveRecord::Migration
  end

class AddMandatoryToQuestionsTable < MIGRATION_CLASS
  def change
    add_column :survey_questions, :mandatory, :boolean, default: false
  end
end
