class Music < ActiveRecord::Base
  has_many :scores
  belongs_to :machine
  belongs_to :season

  validates :name, presence: true
  validates :artist, presence: true
  validates :season, presence: true
  validates_associated :machine
end
