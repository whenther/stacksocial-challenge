class TwitterUser
  include ActiveModel::Model

  attr_accessor :handle
  validates_presence_of :handle
end
