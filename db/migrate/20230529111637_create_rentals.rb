class CreateRentals < ActiveRecord::Migration[7.0]
  def change
    create_table :rentals do |t|
      t.integer :price
      t.float :payload_weight
      t.date :start_date
      t.date :end_date
      t.references :user, null: false, foreign_key: true
      t.references :pigeon, null: false, foreign_key: true
      t.references :payload_type, null: false, foreign_key: true
      t.string :status

      t.timestamps
    end
  end
end
