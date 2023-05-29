class CreatePayloadTypes < ActiveRecord::Migration[7.0]
  def change
    create_table :payload_types do |t|
      t.string :name
      t.float :weight

      t.timestamps
    end
  end
end
