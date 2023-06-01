class CreateReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :reviews do |t|
      t.text :comment, default: '.'
      t.integer :rating, default: 5
      t.references :user, null: false, foreign_key: true
      t.references :rental, null: false, foreign_key: true

      t.timestamps
    end
  end
end
