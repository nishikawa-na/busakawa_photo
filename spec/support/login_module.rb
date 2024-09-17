module LoginModule
  def login(user)
    visit login_path
    fill_in "email", with: user.email
    fill_in "password", with: "12345"
    click_button "ログイン"
    expect(current_path).to eq posts_path
  end
end