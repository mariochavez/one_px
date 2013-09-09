class CreateApiClients < ActiveRecord::Migration
  def change
    create_table :api_clients do |t|
      t.string :identifier, null: false
      t.string :password_digest, null: false

      t.timestamps
    end
  end
end
