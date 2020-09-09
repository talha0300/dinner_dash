class ChangeDataTypeForStatus < ActiveRecord::Migration[5.2]
  def self.up
    change_table :orders do |t|
      t.change :status, :integer,null: false
    end
  end
  def self.down
    change_table :orders do |t|
      t.change :status, :string,null: true
    end
  end
end
