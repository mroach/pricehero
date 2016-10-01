class AddPieceCountToProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :piece_count, :integer, null: false, default: 1
  end
end
