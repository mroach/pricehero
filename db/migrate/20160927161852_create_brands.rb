class CreateBrands < ActiveRecord::Migration[5.0]
  def change
    create_table :brands do |t|
      t.string :name,   null: false
      t.string :country
      t.string :slug

      t.timestamps
      t.datetime :deleted_at
    end
    add_index :brands, :deleted_at
    add_index :brands, :slug, unique: true
  end
end
