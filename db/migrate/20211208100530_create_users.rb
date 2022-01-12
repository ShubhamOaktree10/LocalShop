class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :FirstName
      t.string :LastName
      t.string :email
      t.string :password
      t.text :address
      t.string :city
      t.string :state
      t.string :country
      t.integer :pincode
      t.references :Role, null: false, foreign_key: true

      t.timestamps
    end
  end
end
