class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :cart_id
      t.decimal :total_amount
      t.integer :user_id
      t.string :status

      t.timestamps
    end
  end
end
