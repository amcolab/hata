class AnswersController < ApplicationController
  def update
    current_answer = Answer.find_by(user_id: current_user.id, question_id: Question.active.first)
    @success = current_answer && current_answer.update(answer_params)
    @message = current_answer.errors.full_messages.first unless @success
    respond_to do |format|
      format.js
    end
  end

  def get_assessment_path
    render json: { redirect: assessment_path }
  end

  private

  def answer_params
    params.require(:answer).permit(:content)
  end
end
