module TweetStreamsHelper
  def render_tweet_text(text)
    words = text.split.map do |word|
      # The the word starts with an @ mention, then some text (so loan @s aren't linked)
      if word[0] == '@' && word.length > 1
        link_to(word, tweet_stream_path(id: word[1..-1]))
      else
        word
      end
    end

    words.join(' ').html_safe
  end
end
