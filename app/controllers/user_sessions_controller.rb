class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: %i[new create]
  def new; end

  def create
    if login(params[:name],params[:password])
      flash[:notice] = "ログインしました"
      redirect_to posts_path
    else
      flash.now[:alert] = "ログインに失敗しました"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    logout
    flash[:alert] = "ログアウトしました"
    redirect_to root_path
  end
end
