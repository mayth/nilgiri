require 'scrypt'

class Player < ActiveRecord::Base
  def password=(pw)
    self[:password] = (pw && !pw.empty?) ?
      SCrypt::Password.create(pw) :
      nil
  end

  def password
    self[:password] && SCrypt::Password.new(self[:password])
  end

  def self.authorize(name, pass)
    p = self.find_by(name: name)
    if p && p.password == pass
      p
    else
      nil
    end
  end
end
