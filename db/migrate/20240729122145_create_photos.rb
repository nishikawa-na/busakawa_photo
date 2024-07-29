class CreatePhotos < ActiveRecord::Migration[7.1]
  def change
    create_table :photos do |t|
      t.references :post, null: false, foreign_key: true
      t.string :image, null: false

      t.timestamps
    end
  end
end
