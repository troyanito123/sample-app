class CommentsController < ApplicationController

  before_action :set_post, only: [:create, :destroy, :edit, :update]
  before_action :set_comment, only: [:destroy, :edit, :update]

  def create
    @comment = Comment.new(comment_params)
    @comment.post = @post
    @comment.user = current_user

    if @comment.save
      flash[:success] = I18n.t 'comment.create'
    else
      flash[:danger] = I18n.t 'comment.errors.create'
      redirect_to @post
    end
  end

  def edit
  end

  def update
    @comment.assign_attributes comment_params
    if @comment.save
      flash[:success] = I18n.t 'comment.update'
      redirect_to @post
    else
      render :edit
    end
  end

  def destroy
    @comment.destroy
    flash[:danger] = I18n.t 'comment.destroy'
    redirect_to @post
  end

  private
  def comment_params
    params.require(:comment).permit(:body)
  end

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end


end
