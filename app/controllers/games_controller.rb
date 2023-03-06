class GamesController < ApplicationController
  def index
    @user = User.new
  end

  def create_user
    @user = User.new(user_params)
    if @user.save
      redirect_to answer_path
    else
      render :index, status: :unprocessable_entity
    end
  end

  def answer_round

  end

  private
  def user_params
    params.require(:user).permit(:name)
  end
end
