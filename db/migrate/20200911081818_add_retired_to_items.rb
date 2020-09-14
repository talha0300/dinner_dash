class AddRetiredToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :retird, :boolean, default: false
  end
end
