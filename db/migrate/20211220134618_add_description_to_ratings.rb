class AddDescriptionToRatings < ActiveRecord::Migration[6.1]
  def change
    add_column :ratings, :Description, :string
  end
end
