class Machine < ActiveRecord::Base
  serialize :difficulties, Array
end
