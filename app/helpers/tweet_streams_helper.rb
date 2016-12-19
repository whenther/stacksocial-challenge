module TweetStreamsHelper
  def render_tweet_text(text)
    words = text.split.map do |word|
      if word[0] == '@'
        link_to(word, tweet_stream_path(id: word[1..-1]))
      else
        word
      end
    end

    words.join(' ').html_safe
  end
end
