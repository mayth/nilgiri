class Music < ActiveRecord::Base
  belongs_to :machine
  belongs_to :season

  validates :name, presence: true
  validates :artist, presence: true
  validates :season, presence: true
  validates :machine, presence: true
end
