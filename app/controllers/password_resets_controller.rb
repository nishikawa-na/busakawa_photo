class PasswordResetsController < ApplicationController
  skip_before_action :require_login
  def new; end
  
  def create
    @user = User.find_by_email(params[:email])
    @user.deliver_reset_password_instructions! if @user
    flash[:notice] = "メールを送信しました"
    redirect_to login_path
  end

  def edit
    @token = params[:id]
    @user = User.load_from_reset_password_token(params[:id])

    if @user.blank?
      handle_invalid_token
      return
    end
  end

  def update
    @token = params[:id]
    @user = User.load_from_reset_password_token(params[:id])

    if @user.blank?
      handle_invalid_token
      return
    elsif params[:user][:password].blank?
      flash.now[:alert] = "パスワードの変更に失敗しました パスワードが空です"
      render :edit, status: :unprocessable_entity
      return
    end
    password_update(@user)
  end

  private

  def password_update(user)
    user.password_confirmation = params[:user][:password_confirmation]
    if user.change_password(params[:user][:password])
      flash[:notice] = "パスワードを変更しました"
      redirect_to login_path
    else
      flash.now[:alert] = "パスワードの変更に失敗しました"
      render :edit, status: :unprocessable_entity
    end
  end
end
