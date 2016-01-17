class AddDrawingDateToPickFour < ActiveRecord::Migration[5.0]
  def change
    add_column :pick_fours, :drawing_date, :date
  end
end
