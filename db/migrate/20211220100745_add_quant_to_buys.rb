class AddQuantToBuys < ActiveRecord::Migration[6.1]
  def change
    add_column :buys, :quant, :integer
  end
end
