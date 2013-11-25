class Post < ActiveRecord::Base
  def truncated_body(length: 30, omission: '...')
    if body.length <= length
      body
    else
      body[0..(length - omission.length - 1)] + omission
    end
  end
end
