class AnswersController < ApplicationController
  def index
    @active_question = Question.active.first
    @answers = @active_question.answers.active.with_round(@active_question.current_round)
      .ordered_answers_by_created_at
  end

  def update
    current_answer = Answer.find_by(user_id: current_user.id, question_id: Question.active.first)
    @success = current_answer && current_answer.update(answer_params)
    @message = current_answer.errors.full_messages.first unless @success
    respond_to do |format|
      format.js
    end
  end

  def get_assessment_path
    render json: { redirect: answers_path }
  end

  def get_result_path
    render json: { redirect: result_answers_path }
  end

  def aggregate_points
    # points param format: {points: {answer_id1: point1, answer_id2: point2, answer_id3: point3}}
    answer_ids = params[:points].keys
    if Assessment.by_assessment_user_id(current_user.id).by_answer_id(answer_ids).exists?
      @success = false
      @message = '採点済みのお題を再度採点出来ません。'
    else
      params[:points].each do |answer_id, point|
        answer = Answer.active.find_by_id(answer_id)
        next unless answer
        answer.update_point!(point, current_user)
      end
      @success = true
    end

    respond_to do |format|
      format.js
    end
  end

  def result
    active_question = Question.active.first
    @answers = active_question.answers.active.with_round(active_question.current_round)
      .ordered_answers_by_point.includes(:user)
  end

  private

  def answer_params
    params.require(:answer).permit(:content)
  end
end
