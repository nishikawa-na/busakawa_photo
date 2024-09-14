class CreateLineBotTokens < ActiveRecord::Migration[7.1]
  def change
    create_table :line_bot_tokens do |t|
      t.string :line_user_id, null: false
      t.string :line_user_id_token, null: false

      t.timestamps
    end
    add_index :line_bot_tokens, [:line_user_id_token]
  end
end
