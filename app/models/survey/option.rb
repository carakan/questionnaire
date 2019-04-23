# frozen_string_literal: true

class Survey::Option < ActiveRecord::Base
  self.table_name = 'survey_options'

  belongs_to :question
  has_many :answers
  validates :text,
            presence: true,
            allow_blank: false,
            if:
              proc { |o|
                [
                  Survey::OptionsType.multi_choices,
                  Survey::OptionsType.single_choice,
                  Survey::OptionsType.single_choice_with_text,
                  Survey::OptionsType.single_choice_with_number,
                  Survey::OptionsType.multi_choices_with_text,
                  Survey::OptionsType.multi_choices_with_number,
                  Survey::OptionsType.large_text
                ].include?(o.options_type_id)
              }
  validates :options_type_id, presence: true
  validates :options_type_id,
            inclusion: {
              in: Survey::OptionsType.options_type_ids,
              unless: proc { |o| o.options_type_id.blank? }
            }
  scope :correct, -> { where(correct: true) }
  scope :incorrect, -> { where(correct: false) }
  before_create :default_option_weigth

  def to_s
    text
  end

  def correct?
    correct == true
  end

  def text
    I18n.locale == I18n.default_locale ? super : locale_text.presence || super
  end

  private

  def default_option_weigth
    self.weight = 1 if correct && weight == 0
  end
end
