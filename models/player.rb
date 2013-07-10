class Player
  include Mongoid::Document

  field :id, type: String
  field :screen_name, type: String
  field :pass, type: String
  field :twitter_id, type: String
  field :registered_at, type: DateTime, default: -> { Time.now }
  has_many :scores
end
