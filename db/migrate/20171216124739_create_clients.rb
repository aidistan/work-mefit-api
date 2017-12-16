class CreateClients < ActiveRecord::Migration[5.1]
  def change
    create_table :clients do |t|
      t.string :uuid
      t.string :secret
      t.string :redirect_uri
      t.string :name
      t.string :codename

      t.timestamps
    end
    add_index :clients, :uuid, unique: true
    add_index :clients, :codename, unique: true
  end
end
