class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :mobile
      t.string :nickname
      t.string :password_digest
      t.string :weixin_id
      t.integer :gender, default: 2 # unknown
      t.date :birthday

      t.timestamps
    end
    add_index :users, :mobile, unique: true
    add_index :users, :nickname, unique: true
    add_index :users, :weixin_id, unique: true
  end
end
