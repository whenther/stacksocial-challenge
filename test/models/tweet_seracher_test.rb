require 'test_helper'

class TweetSearcherTest < ActiveSupport::TestCase
  test "new tweet search" do
    stub_request(:post, 'https://api.twitter.com/oauth2/token')
      .to_return(
        body: {
          access_token: '123'
        }.to_json,
        status: 200,
        headers: { 'Content-Type' => 'application/json' }
      )

    stub_request(
      :get,
      'https://api.twitter.com/1.1/statuses/user_timeline.json?count=25&screen_name=NewHandle'
    )
      .with(headers: { 'Authorization' => 'Bearer 123' })
      .to_return(
        body: [
          {
            created_at: "Fri Dec 16 17:00:30 +0000 2016",
            text: "This is a tweet."
          }
        ].to_json,
        status: 200,
        headers: { 'Content-Type' => 'application/json' }
      )

    tweets = TweetSearcher.new('NewHandle').tweets
    assert tweets[0][:text] == "This is a tweet."
  end

  test "cached tweet search" do
    # Request a handle from the fixtures.
    tweets = TweetSearcher.new('Handle1').tweets
    assert tweets[0][:text] == "just setting up my twttr"
  end

  private

  def stub_requests
  end
end
