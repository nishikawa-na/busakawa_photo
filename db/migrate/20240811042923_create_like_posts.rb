class CreateLikePosts < ActiveRecord::Migration[7.1]
  def change
    create_table :like_posts do |t|
      t.references :user, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true

      t.timestamps
    end
    add_index :like_posts, [ :post_id, :user_id ], unique: true
  end
end
