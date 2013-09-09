class CreateApiAuthorizations < ActiveRecord::Migration
  def change
    create_table :api_authorizations do |t|
      t.integer :user_id, null: false
      t.string :token, null: false
      t.datetime :expiration, null: false

      t.timestamps
    end

    add_index :api_authorizations, [:user_id, :token]
  end
end
