require 'test_helper'

class TweetStreamsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get tweet_streams_index_url
    assert_response :success
  end

  test "should get show" do
    get tweet_streams_show_url
    assert_response :success
  end

end
