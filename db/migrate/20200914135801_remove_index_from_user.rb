class RemoveIndexFromUser < ActiveRecord::Migration[5.2]
  def change

    remove_index :users, name: "index_users_on_user_name"
  end
end
