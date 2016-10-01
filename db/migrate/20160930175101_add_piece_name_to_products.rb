class AddPieceNameToProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :piece_name, :string
  end
end
