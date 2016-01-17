class AddStateRefToPickThrees < ActiveRecord::Migration[5.0]
  def change
    add_reference :pick_threes, :state, index: true, foreign_key: true
  end
end
