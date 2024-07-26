class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: %i[new create]
  def new; end

  def create
    if login(params[:email],params[:password])
      redirect_to root_path
      ##パス先は後で修正
    else
      render :new
    end
  end

  def destroy
    logout
    redirect_to login_path
  end
end
