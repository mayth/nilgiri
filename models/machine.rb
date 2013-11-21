class Machine < ActiveRecord::Base
  serialize :difficulties, Array
  has_many :musics
end
