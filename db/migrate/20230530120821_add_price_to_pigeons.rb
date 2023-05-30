class AddPriceToPigeons < ActiveRecord::Migration[7.0]
  def change
    add_column :pigeons, :price, :integer
  end
end
