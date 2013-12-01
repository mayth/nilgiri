require 'time'

class Season < ActiveRecord::Base
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
