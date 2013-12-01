require 'time'

class Season < ActiveRecord::Base
  has_many :musics
  has_many :scores

  validates :name, presence: true, uniqueness: true
  validates :start, presence: true
  validates :expiry, presence: true

  def self.for(time)
    t = nil
    case time
    when :now
      t = Time.now
    when String
      t = Time.parse(time)
    when Time
      t = time
    else
      raise TypeError
    end
    Season.where(['start <= ? and ? <= expiry', t, t]).first
  end

  def range
    (start..expiry)
  end
end
