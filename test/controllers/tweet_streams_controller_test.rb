require 'test_helper'

class TweetStreamsControllerTest < ActionDispatch::IntegrationTest
  test "should protect index" do
    get tweet_streams_url
    assert_response :found
  end
end
