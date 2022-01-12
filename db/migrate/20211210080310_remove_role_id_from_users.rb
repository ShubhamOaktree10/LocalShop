class RemoveRoleIdFromUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :Role_id, :integer
  end
end
