class Music < ActiveRecord::Base
  belongs_to :machine
  belongs_to :season
end
