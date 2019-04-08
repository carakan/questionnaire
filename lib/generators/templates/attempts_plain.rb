# frozen_string_literal: true

class <%= get_scope.capitalize %>::AttemptsController < ApplicationController
  helper '<%= get_scope %>/surveys'

  def new
    @survey =  Survey::Survey.active.last
    @attempt = @survey.attempts.new
    @attempt.answers.build
    @participant = current_user # you have to decide what to do here
  end

  def create
    @survey = Survey::Survey.active.last
    @attempt = @survey.attempts.new(attempt_params)
    @attempt.participant = current_user # you have to decide what to do here
    if @attempt.valid? && @attempt.save
      redirect_to view_context.new_attempt_path, alert: I18n.t("attempts_controller.#{action_name}")
    else
      flash.now[:error] = @attempt.errors.full_messages.join(', ')
      render action: :new
    end
  end

  #######
  private

  def attempt_params
    params.require(:survey_attempt).permit(answers_attributes: %i[question_id option_id option_text option_number predefined_value_id])
  end
end
