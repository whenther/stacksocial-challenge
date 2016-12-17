class TweetStreamsController < ApplicationController
  def index
    @twitter_user = TwitterUser.new
  end

  def create
    @twitter_user = TwitterUser.new(twitter_user_params)

    if @twitter_user.valid?
      redirect_to(action: 'show', id: @twitter_user.name)
    else
      render 'index'
    end
  end

  def show
    @twitter_user = TwitterUser.new({name: params[:id]})

    @tweets = []
  end

  def twitter_user_params
    params.require(:twitter_user).permit(:name)
  end
end
