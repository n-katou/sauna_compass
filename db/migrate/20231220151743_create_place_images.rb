class CreatePlaceImages < ActiveRecord::Migration[6.1]
  def change
    create_table :place_images do |t|
      t.string :image_url, null: false
      t.references :place, foreign_key: true

      t.timestamps
    end
  end
end
