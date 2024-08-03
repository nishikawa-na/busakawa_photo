class PostsController < ApplicationController
  skip_before_action :require_login, only: %i[index]
  def index
    
  end

  def show
  end

  def new
    @post= Post.new
  end

  def create
    @post = Post.new(params_post)
    if @post.save
      redirect_to posts_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def params_post
    params.require(:post).permit(:title, :body, :images_cache, {images: []}).merge(user_id: current_user.id)
  end
end
