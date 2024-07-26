class SorceryCore < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :name,             null: false
      t.string :email,            null: false, index: { unique: true }
      t.string :crypted_password
      t.string :salt
      t.string :instagram_account_url
      t.string :line_user_id
      t.timestamps                null: false
    end
    add_index :users, :instagram_account_url, unique: true
    add_index :users, :line_user_id, unique: true
  end
end
