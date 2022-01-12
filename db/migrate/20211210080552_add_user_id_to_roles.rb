class AddUserIdToRoles < ActiveRecord::Migration[6.1]
  def change
    add_column :roles, :user_id, :integer
  end
end
