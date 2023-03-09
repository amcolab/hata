class GamesController < ApplicationController
  # Access to regist user screen
  def index
    count_joined_room_users
    @user = User.new
  end

  # Create new user and redirect to answer the question screen
  def create_user
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      active_question = find_or_create_active_question
      if (active_question.time_start + 4.minute) < Time.current
        redirect_to result_answers_path and return
      elsif (active_question.time_start + 2.minute) < Time.current
        redirect_to answers_path and return
      end
      redirect_to answer_round_path
    else
      flash[:error] = { user_login: @user.errors.messages }
      render :index, status: :unprocessable_entity
    end
  end

  # Display answer the question screen
  def answer_round
    active_question = Question.active.first
    active_question.update(time_start: Time.current) if active_question.time_start.nil?
    @answer = current_user.answers.active.find_by(round: active_question.current_round) || current_user.answers.create!(question: active_question, status: 'active', round: active_question.current_round)
  end

  # Archived a question, after finish display result screen
  def archived_question
    active_question = Question.active.first
    if active_question && params[:id].present? && active_question.id == params[:id].to_i
      active_question.archived!
      active_question.answers.active.update_all(status: 'archived')
      find_or_create_active_question
    end
    render json: { redirect: answer_round_path }
  end

  private
  def user_params
    params.require(:user).permit(:name)
  end

  def count_joined_room_users
    active_question = Question.active.first
    @joined_room_users_count = active_question ? active_question.answers.active.with_round(active_question.current_round).count : 0
  end

  def find_or_create_active_question
    Question.find_or_create_active_question
  end
end
