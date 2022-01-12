class CreateQuantities < ActiveRecord::Migration[6.1]
  def change
    create_table :quantities do |t|
      t.integer :total
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
