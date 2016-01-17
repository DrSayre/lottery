class CreatePickFours < ActiveRecord::Migration[5.0]
  def change
    create_table :pick_fours do |t|
      t.integer :first_number
      t.integer :second_number
      t.integer :third_number
      t.integer :fourth_number
      t.references :drawing_time, index: true, foreign_key: true
      t.references :state, index: true, foreign_key: true

      t.timestamps
    end
  end
end
