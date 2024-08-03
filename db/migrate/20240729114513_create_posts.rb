class CreatePosts < ActiveRecord::Migration[7.1]
  def change
    create_table :posts do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title, null: false
      t.string :body, null: false
      t.json :images, null: false

      t.timestamps
    end
  end
end
