class CreateShops < ActiveRecord::Migration[6.1]
  def change
    create_table :shops do |t|
      t.string :name
      t.string :city
      t.string :state
      t.string :country
      t.integer :pincode
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
