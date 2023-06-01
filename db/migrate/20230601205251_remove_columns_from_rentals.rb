class RemoveColumnsFromRentals < ActiveRecord::Migration[7.0]
  def change
    remove_reference :rentals, :payload_type, null: false, foreign_key: true
    remove_column :rentals, :service_fee_per_day, :integer
    remove_column :rentals, :tax_rate, :float
  end
end
