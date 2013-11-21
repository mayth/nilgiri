class Music < ActiveRecord::Base
  has_many :scores
  belongs_to :machine
end
