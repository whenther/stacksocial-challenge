class TweetSearcher
  CREDENTIALS = Base64.strict_encode64(ENV['TWITTER_KEY'] + ':' + ENV['TWITTER_SECRET'])
  BASE_URL = 'https://api.twitter.com/'
  TOKEN_URL = BASE_URL + 'oauth2/token'
  TWEETS_URL = BASE_URL + '1.1/statuses/user_timeline.json'

  attr_reader :tweets

  def initialize(handle)
    @handle = handle

    cached_tweet_stream = TweetStream.where(
      handle: @handle,
      created_at: 5.minutes.ago..Time.current
    ).order(:created_at).last

    @tweets =
      if cached_tweet_stream
        puts "CACHED----------"
        cached_tweet_stream.tweets.order(posted: :desc)
      else
        puts "FETCH----------"
        fetch_and_cache_tweets.order(posted: :desc)
      end
  end

  private

  def fetch_and_cache_tweets
    # Create a new stream object for the user.
    tweet_stream = TweetStream.new(handle: @handle)

    return unless tweet_stream

    # Get and save their latest tweets.
    @token = fetch_bearer_token
    tweet_stream.tweets.build(fetch_tweets)
    tweet_stream.save

    # Return the tweets.
    tweet_stream.tweets
  end

  def fetch_bearer_token
    result = HTTParty.post(
      TOKEN_URL,
      body: 'grant_type=client_credentials',
      headers: {
        "Authorization" => "Basic #{CREDENTIALS}",
        "Content-Type" => "application/x-www-form-urlencoded"
      }
    )

    result["access_token"]
  end

  def fetch_tweets
    tweets =
      HTTParty.get(
        TWEETS_URL,
        query: {
          count: 25,
          screen_name: @handle
        },
        headers: {
          "Authorization" => "Bearer #{@token}"
        }
      )

    return [] unless tweets.code == 200

    # Return data ready to be converted to Tweets.
    tweets.map do |tweet|
      {
        posted: tweet["created_at"],
        text: tweet["text"]
      }
    end
  end
end
