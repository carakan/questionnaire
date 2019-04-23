# frozen_string_literal: true

class Survey::Question < ActiveRecord::Base
  self.table_name = 'survey_questions'

  has_many :options
  has_many :predefined_values
  has_many :answers
  belongs_to :section
  accepts_nested_attributes_for :options,
                                reject_if: ->(a) { a[:options_type_id].blank? }, allow_destroy: true
  accepts_nested_attributes_for :predefined_values,
                                reject_if: ->(a) { a[:name].blank? }, allow_destroy: true
  validates :text, presence: true, allow_blank: false
  validates :questions_type_id, presence: true
  validates :questions_type_id,
            inclusion: {
              in: Survey::QuestionsType.questions_type_ids,
              unless: proc { |q| q.questions_type_id.blank? }
            }
  scope :mandatory_only, -> { where(mandatory: true) }

  def correct_options
    options.correct
  end

  def incorrect_options
    options.incorrect
  end

  def text
    I18n.locale == I18n.default_locale ? super : locale_text.presence || super
  end

  def description
    if I18n.locale == I18n.default_locale
      super
    else
      locale_description.presence || super
    end
  end

  def head_number
    if I18n.locale == I18n.default_locale
      super
    else
      locale_head_number.presence || super
    end
  end

  def mandatory?
    mandatory == true
  end
end
