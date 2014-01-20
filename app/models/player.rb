require 'scrypt'

class Player < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true,
    format: { with: /\A[a-zA-Z0-9_]+\z/ }
  validates :password, presence: true

  def screen_name
    self[:screen_name].presence || self[:name]
  end

  def password=(pw)
    self[:password] = pw.present? ?
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
