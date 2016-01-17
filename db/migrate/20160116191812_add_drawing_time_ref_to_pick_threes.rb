class AddDrawingTimeRefToPickThrees < ActiveRecord::Migration[5.0]
  def change
    add_reference :pick_threes, :drawing_time, index: true, foreign_key: true
  end
end
