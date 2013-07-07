class Player
  include Mongoid::Document

  field :name, type: String
  field :screen_name, type: String
  field :pass, type: String
  field :registered_at, type: DateTime
  has_many :scores
end
