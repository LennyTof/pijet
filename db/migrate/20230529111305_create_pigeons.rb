class CreatePigeons < ActiveRecord::Migration[7.0]
  def change
    create_table :pigeons do |t|
      t.string :name
      t.float :maximum_payload_weight
      t.integer :range
      t.text :description
      t.float :latitude
      t.float :longitude
      t.string :address
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
