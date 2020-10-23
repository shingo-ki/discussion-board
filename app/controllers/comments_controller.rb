class CommentsController < ApplicationController
  def create
    @subject = Subject.find(params[:subject_id])
    @comment = @subject.comments.new(comment_params)
    if logged_in?
      @comment.user_id = current_user.id
    else
      @comment.user_id = 1
    end  
    if @comment.save
      flash[:success] = 'コメントを投稿しました。'
      redirect_to @subject
    else
      redirect_to @subject
    end  
  end

  def edit
    @comment = current_user.comments.find_by(id:params[:id])
    @subject = @comment.subject
  end

  def update
    @subject = Subject.find(params[:subject_id])
    @comment = current_user.comments.find_by(id:params[:id])
    if @comment.update(comment_params)
      flash[:success] = "コメントは正常に更新されました。"
      redirect_to @subject
    else
      flash.now[:danger] = "コメントは更新されませんでした。"
      render :@subject
    end  
  end

  def destroy
    @comment = Comment.find(params[:id])
    @subject = @comment.subject 
    Comment.find_by(id: params[:id],subject_id: params[:subject_id]).destroy
    flash[:success] = "コメントは正常に削除されました。"
    redirect_to @subject
  end


  private
  
  
  def comment_params
    params.require(:comment).permit(:message)
  end
  
end  