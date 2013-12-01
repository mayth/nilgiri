class Season < ActiveRecord::Base
  def range
    (start..expiry)
  end
end
