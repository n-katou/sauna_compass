class CreatePlaces < ActiveRecord::Migration[6.1]
  def change
    create_table :places do |t|
      t.string :name, null: false
      t.string :address
      t.float :rating_avg
      t.decimal :longitude, precision: 10, scale: 7, null: false
      t.decimal :latitude, precision: 10, scale: 7, null: false
      t.string :phone_number
      t.string :opening_hours
      t.string :website

      t.timestamps
    end
  end
end
