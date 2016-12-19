class TweetStreamsController < ApplicationController
  before_action :protect

  def index
    @twitter_user = TwitterUser.new
  end

  def create
    @twitter_user = TwitterUser.new(twitter_user_params)

    if @twitter_user.valid?
      redirect_to(action: 'show', id: @twitter_user.handle)
    else
      render 'index'
    end
  end

  def show
    @twitter_user = TwitterUser.new(handle: params[:id])
    @tweets = TweetSearcher.new(params[:id]).tweets
  end

  private

  def twitter_user_params
    params.require(:twitter_user).permit(:handle)
  end
end
