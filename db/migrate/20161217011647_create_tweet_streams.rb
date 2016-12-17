class CreateTweetStreams < ActiveRecord::Migration[5.0]
  def change
    create_table :tweet_streams do |t|
      t.string :handle

      t.timestamps
    end

    create_table :tweets do |t|
      t.string :text
      t.datetime :posted

      t.timestamps
    end

    add_reference :tweets, :tweet_streams, index: true, foreign_key: true
    add_index :tweet_streams, :handle
  end
end
