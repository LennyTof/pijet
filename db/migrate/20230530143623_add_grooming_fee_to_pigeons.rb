class AddGroomingFeeToPigeons < ActiveRecord::Migration[7.0]
  def change
    add_column :pigeons, :grooming_fee, :integer
  end
end
