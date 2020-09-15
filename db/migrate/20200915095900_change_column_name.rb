class ChangeColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :items, :retird, :retired
  end
end
