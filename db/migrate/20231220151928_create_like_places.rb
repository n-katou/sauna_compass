class CreateLikePlaces < ActiveRecord::Migration[6.1]
  def change
    create_table :like_places do |t|
      t.references :customer, foreign_key: true
      t.references :place, foreign_key: true

      t.timestamps
    end
  end
end
