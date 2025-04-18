class ApplicationController < ActionController::Base
  before_action :require_login, :set_ransack

  def not_authenticated
    flash[:alert] = "ログインしてください"
    redirect_to root_path
  end

  def handle_invalid_token
    flash[:alert] = "パスワード変更フォームよりやり直してください"
    redirect_to new_password_reset_path
  end

  def set_ransack
    @q = Post.ransack(params[:q])
    @posts = @q.result.includes(:user, :like_posts).order("created_at DESC").page(params[:page])
  end
end
