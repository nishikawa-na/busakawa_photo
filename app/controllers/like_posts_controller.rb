class LikePostsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @like_post = @post.like_posts.new(user_id: current_user.id)
    @like_post.save
  end

  def destroy
    @post = current_user.like_posts.find(params[:id]).post
    like_post = current_user.like_posts.find(params[:id])
    like_post.destroy
  end
end
