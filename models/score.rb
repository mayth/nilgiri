class Score
  include Mongoid::Document

  field :registration_target, type: String
  field :registered_at, type: DateTime
  field :difficulty, type: Symbol
  field :score, type: Float
  belongs_to :player
end
