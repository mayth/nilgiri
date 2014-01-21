class Season < ActiveRecord::Base
  has_many :musics
  has_many :scores

  validates :name, presence: true
  validates :start, presence: true
  validates :expiry, presence: true
  validate :start_must_be_before_expiry

  def start_must_be_before_expiry
    if (start.present? && expiry.present?) && (start > expiry)
      errors.add(:expiry, "can't be after the start datetime")
    end
  end

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
