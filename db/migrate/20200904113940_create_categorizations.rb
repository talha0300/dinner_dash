class CreateCategorizations < ActiveRecord::Migration[5.2]
  def change
    create_table :categorizations do |t|
      t.references :item, foreign_key: true
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
