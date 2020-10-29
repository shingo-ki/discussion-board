class SubjectsController < ApplicationController
  
  before_action :require_user_logged_in, only: [:new, :create, :edit, :update]
  
  def show
    @subject = Subject.find(params[:id])
    @comments = @subject.comments
    if logged_in?
      @comment = current_user.comments.new
    else
      user = User.find(1)
      @comment = user.comments.new
    end
  end

  def new
    @subject = Subject.new
    @comment = Comment.new
  end

  def create
    @subject = current_user.subjects.build(subject_params)
    if @subject.save
      flash[:success] = '掲題を投稿しました。'
      redirect_to root_url
    else
      @subjects = Subject.order(id: :desc).page(params[:page])
      flash.now[:danger] = '掲題の投稿に失敗しました。'
      render new_subject_path
    end  
  end

  def edit
     @subject = current_user.subjects.find(params[:id])
  end
  
  def update
    @subject = current_user.subjects.find_by(id:params[:id])
    if @subject.update(subject_params)
      flash[:success] = "掲題は正常に更新されました。"
      redirect_to @subject
    else
      flash.now[:danger] = "掲題は更新されませんでした。"
      render :edit
    end  
  end
  
  private
  
  def subject_params
    params.require(:subject).permit(:content)
  end
  
end
