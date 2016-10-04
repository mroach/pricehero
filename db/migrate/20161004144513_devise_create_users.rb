class DeviseCreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :encrypted_password, null: false, default: ''

      t.string :name, null: false
      t.string :nickname
      t.string :slug
      t.integer :role, null: false, default: 0

      ## Rememberable
      t.datetime :remember_created_at

      t.timestamps null: false
      t.datetime :deleted_at
    end

    add_index :users, :email, unique: true
    add_index :users, :slug, unique: true
    add_index :users, :deleted_at
  end
end
