# Drawing Time (i.e. midday evening etc)
class DrawingTime < ApplicationRecord
  has_many :pick_threes
  has_many :pick_fours
end
