class FavoritesController < ApplicationController
  before_action :require_user_logged_in
  
  
  def create
    comment = Comment.find(params[:comment_id])
    current_user.favorite(comment)
    flash[:success] = "この投稿をお気に入りにしました。"
    redirect_to root_path
  end

  def destroy
    comment = Comment.find(params[:comment_id])
    current_user.unfavorite(comment)
    flash[:success] = "この投稿をお気に入りから削除しました。"
    redirect_to root_path
  end
end
