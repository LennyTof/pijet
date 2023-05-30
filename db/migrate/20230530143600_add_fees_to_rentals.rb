class AddFeesToRentals < ActiveRecord::Migration[7.0]
  def change
    add_column :rentals, :service_fee_per_day, :integer
    add_column :rentals, :tax_rate, :float
  end
end
