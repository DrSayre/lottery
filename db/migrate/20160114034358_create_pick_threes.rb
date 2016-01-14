class CreatePickThrees < ActiveRecord::Migration[5.0]
  def change
    create_table :pick_threes do |t|
      t.column :first_number, :integer
      t.column :second_number, :integer
      t.column :third_number, :integer
      t.column :drawing_date, :date

      t.timestamps
    end
  end
end
