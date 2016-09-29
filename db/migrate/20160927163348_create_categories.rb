class CreateCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :categories do |t|
      t.string :name,           null: false
      t.string :standard_units
      t.string :slug

      t.timestamps
      t.datetime :deleted_at
    end
    add_index :categories, :deleted_at
    add_index :categories, :slug, unique: true
  end
end
