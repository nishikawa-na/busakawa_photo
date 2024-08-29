class PostsController < ApplicationController
  skip_before_action :require_login, only: %i[index]

  def index; end

  def show
    @post = Post.includes(:user, :comments, :like_posts).find(params[:id])
    @comment = Comment.new
    unless PostCount.where(created_at: Time.zone.now.all_day).find_by(user_id: current_user.id, post_id: @post.id)
      current_user.post_counts.create(post_id: @post.id)
    end
  end

  def new
    @post= Post.new
  end

  def create
    @post = Post.new(params_post)
    if @post.save
      flash[:notice] = "投稿作成しました"
      redirect_to posts_path
    else
      flash.now[:alert] = "投稿作成に失敗しました"
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @post = current_user.posts.find(params[:id])
  end

  def update
    @post = current_user.posts.find(params[:id])
    if @post.update(params_post)
      flash[:notice] = "投稿編集しました"
      redirect_to post_path(@post)
    else
      flash.now[:alert] = "投稿編集に失敗しました"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post = current_user.posts.find(params[:id])
    if @post.destroy
      flash[:alert] = "投稿削除しました"
      redirect_to posts_path
    else
      flash.now[:alert] = "投稿削除に失敗しました"
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def params_post
    params.require(:post).permit(:title, :body, :images_cache, {images: []}).merge(user_id: current_user.id)
  end

end
