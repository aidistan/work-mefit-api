class CreateTokens < ActiveRecord::Migration[5.1]
  def change
    create_table :tokens do |t|
      t.string :uuid
      t.integer :kind, default: 0 # access
      t.integer :expires_in
      t.datetime :expires_at
      t.string :last_used_ip
      t.datetime :last_used_at

      t.belongs_to :user
      t.belongs_to :client

      t.timestamps
    end
    add_index :tokens, :uuid, unique: true
  end
end
