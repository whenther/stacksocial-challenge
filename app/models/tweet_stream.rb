class TweetStream < ApplicationRecord
  has_many :tweets, dependent: :destroy
end
