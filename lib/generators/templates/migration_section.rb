# frozen_string_literal: true

MIGRATION_CLASS =
  if ActiveRecord::VERSION::MAJOR >= 5
    ActiveRecord::Migration["#{ActiveRecord::VERSION::MAJOR}.#{ActiveRecord::VERSION::MINOR}"]
  else
    ActiveRecord::Migration
  end

class CreateSections < MIGRATION_CLASS
  def self.up
    create_table :survey_sections do |t|
      t.string :head_number
      t.string :name
      t.text :description
      t.integer :survey_id

      t.timestamps
    end

    remove_column :survey_questions, :survey_id
    add_column :survey_questions, :section_id, :integer
  end

  def self.down
    drop_table :survey_sections

    remove_column :survey_questions, :section_id
    add_column :survey_questions, :survey_id, :integer
  end
end
