# links pick 3 and pick 4 to which state it's for
class State < ApplicationRecord
  has_many :pick_threes
  has_many :pick_fours
end
