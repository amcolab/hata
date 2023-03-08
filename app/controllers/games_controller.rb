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
      active_question = Question.find_or_create_active_question
      active_question.update(time_start: Time.current) if active_question.time_start.nil?
      @user.answers.create!(question: active_question, status: 'active', round: active_question.current_round)
      redirect_to answer_path
    else
      flash[:error] = { user_login: @user.errors.messages }
      render :index, status: :unprocessable_entity
    end
  end

  # Display answer the question screen
  def answer_round
    @answer = current_user.answers.active.first
  end

  # Display assessment screen
  def assessment_round
    @question = Question.find_or_create_active_question
    @assessment = Assessment.new()
  end

  private
  def user_params
    params.require(:user).permit(:name)
  end

  def count_joined_room_users
    active_question = Question.active.first
    @joined_room_users_count = active_question ? Answer.active.with_round(active_question.current_round).count : 0
  end
end
