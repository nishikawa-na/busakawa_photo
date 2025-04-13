class RemoveAccessCountToResetPasswordPageFromUsers < ActiveRecord::Migration[7.1]
  def change
    remove_column :users, :access_count_to_reset_password_page, :integer
  end
end
