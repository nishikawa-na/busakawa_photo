class PostsController < ApplicationController
  skip_before_action :require_login, only: %i[index]

  def index
    @posts = Post.includes(:user).order("created_at DESC").page(params[:page])
  end

  def show
    @post = Post.includes(:user, :comments).find(params[:id])
    @comment = Comment.new
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
    @post = current_user.posts.find(params[:id])
  end

  def update
    @post = current_user.posts.find(params[:id])
    if @post.update(params_post)
      redirect_to post_path(@post)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post = current_user.posts.find(params[:id])
    if @post.destroy
      redirect_to posts_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def params_post
    params.require(:post).permit(:title, :body, :images_cache, {images: []}).merge(user_id: current_user.id)
  end

end
