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
    end

    @user.password_confirmation = params[:user][:password_confirmation]
    @user.increment_password_reset_page_access_counter

    if @user.restrict_password_reset_access == false
      flash[:alert] = "回数が上限になりました。 30分後に実施してください"
      redirect_to new_password_reset_path
      return
    end

    begin
      @user.change_password!(params[:user][:password])
      @user.reset_password_reset_page_access_counter
      flash[:notice] = "パスワードを変更しました"
      redirect_to login_path
    rescue ArgumentError => e
      flash.now[:alert] = "パスワードを入力してください"
      render :edit, status: :unprocessable_entity
    rescue ActiveRecord::RecordInvalid => e
      flash.now[:alert] = "パスワードの変更に失敗しました"
      render :edit, status: :unprocessable_entity
    end
  end
end
