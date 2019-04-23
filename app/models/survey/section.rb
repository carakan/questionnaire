# frozen_string_literal: true

class Survey::Section < ActiveRecord::Base
  self.table_name = 'survey_sections'

  has_many :questions
  belongs_to :survey
  accepts_nested_attributes_for :questions,
                                reject_if: ->(q) { q[:text].blank? }, allow_destroy: true
  validates :name, presence: true, allow_blank: false
  validate :check_questions_requirements

  def name
    I18n.locale == I18n.default_locale ? super : locale_name.presence || super
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

  def full_name
    head_name = head_number.blank? ? '' : "#{head_number}: "
    "#{head_name}#{name}"
  end

  private

  # a section only can be saved if has one or more questions and options
  def check_questions_requirements
    if questions.empty? || questions.collect(&:options).empty?
      errors.add(:base, 'Section without questions or options cannot be saved')
    end
  end
end
