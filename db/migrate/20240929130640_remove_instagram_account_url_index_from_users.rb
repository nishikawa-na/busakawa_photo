class RemoveInstagramAccountUrlIndexFromUsers < ActiveRecord::Migration[7.1]
  def change
      remove_index :users, :instagram_account_url
  end
end
