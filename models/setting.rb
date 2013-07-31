class Setting
  include Mongoid::Document

  field :key,  type: Symbol
  field :value
end
