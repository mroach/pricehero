class AddGtinToVariants < ActiveRecord::Migration[5.0]
  def change
    add_column :variants, :gtin, :string
  end
end
