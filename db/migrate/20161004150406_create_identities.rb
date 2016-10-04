class CreateIdentities < ActiveRecord::Migration[5.0]
  def change
    create_table :identities do |t|
      t.references :user, foreign_key: true
      t.string :provider, null: false
      t.string :uid, null: false
      t.jsonb :info

      t.timestamps
      t.datetime :deleted_at
    end
    add_index :identities, :deleted_at
    add_index :identities, %i(user_id provider), unique: true
    add_index :identities, %i(provider uid), unique: true
  end
end
