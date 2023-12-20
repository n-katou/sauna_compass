class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.text :comment, null: false
      t.integer :rating_1, null: false
      t.integer :rating_2, null: false
      t.integer :rating_3, null: false
      t.integer :rating_4, null: false
      t.integer :rating_5, null: false
      t.references :customer, foreign_key: true
      t.references :place, foreign_key: true
      t.timestamps
    end
  end
end
