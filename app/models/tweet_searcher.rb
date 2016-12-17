class TweetSearcher
  CREDENTIALS = credentials
  BASE_URL = 'https://api.twitter.com/'
  TOKEN_URL = BASE_URL + 'oauth2/token'
  TWEETS_URL = BASE_URL + '1.1/statuses/user_timeline.json'

  def initialize(handle)
    @handle = handle
    @token = bearer_token
  end

  private

  def bearer_token
    HTTParty.post(
      TOKEN_URL,
      body: 'grant_type=client_credentials',
      headers: {
        "Authorization" => "Basic #{CREDENTIALS}",
        "Content-Type" => "application/x-www-form-urlencoded"
      }
    ).access_token
  end

  def tweets
    HTTParty.post(
      TWEETS_URL,
      query: {
        count: 25,
        screen_name: @handle
      },
      headers: {
        "Authorization" => "Bearer #{@token}"
      }
    )
  end

  def credentials
    creds = ENV['TWITTER_KEY'] + ':' + ENV['TWITTER_SECRET']
    Base64.encode64(creds)
  end
end
