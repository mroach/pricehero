class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.references :brand,    foreign_key: true
      t.string     :name,     null: false
      t.references :category, foreign_key: true
      t.string     :units
      t.string     :gtin
      t.string     :slug

      t.timestamps
      t.datetime :deleted_at
    end
    add_index :products, :deleted_at
    add_index :products, :slug, unique: true
  end
end
