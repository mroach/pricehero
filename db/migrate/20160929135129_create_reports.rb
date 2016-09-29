class CreateReports < ActiveRecord::Migration[5.0]
  def change
    create_table :reports do |t|
      t.references :product,     foreign_key: true
      t.references :store,       foreign_key: true
      t.datetime   :reported_at, null: false
      t.monetize   :price
      t.boolean    :out_of_stock

      t.timestamps
      t.datetime :deleted_at
    end
    add_index :reports, :reported_at
    add_index :reports, :deleted_at
  end
end
