class CreateProductMedia < ActiveRecord::Migration[5.0]
  def change
    create_table :product_media do |t|
      t.references :product,      foreign_key: true, null: false
      t.string     :file,         null: false
      t.string     :content_type, null: false
      t.integer    :size,         null: false, default: 0
      t.string     :title
      t.integer    :position

      t.timestamps
      t.datetime :deleted_at, index: true
    end
  end
end
