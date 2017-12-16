class CreateRoles < ActiveRecord::Migration[5.1]
  def change
    create_table :roles do |t|
      t.string :name
      t.string :description

      t.timestamps
    end
    add_index :roles, :name, unique: true

    create_join_table :users, :roles, table_name: :users_roles
  end
end
