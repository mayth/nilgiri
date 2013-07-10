class Score
  include Mongoid::Document

  field :registration_target, type: Symbol
  field :registered_at, type: DateTime
  field :machine, type: Symbol
  field :difficulty, type: Symbol
  field :score, type: Float
  field :score_type, type: Symbol
  belongs_to :player
end
