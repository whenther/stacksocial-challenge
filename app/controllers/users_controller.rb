class UsersController < ApplicationController
  before_action :protect, only: [:show]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      log_in @user
      flash[:success] = "Welcome #{@user.username}!"
      redirect_to tweet_streams_path
    else
      render 'new'
    end
  end

  def show
    @user = find_user
  end

  private

  def find_user
    User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(
      :username,
      :password,
      :password_confirmation
    )
  end
end
