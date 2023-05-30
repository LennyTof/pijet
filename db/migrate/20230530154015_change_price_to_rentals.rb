class ChangePriceToRentals < ActiveRecord::Migration[7.0]
  def change
    change_column :rentals, :price, :float
  end
end
