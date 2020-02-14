class PostsController < ApplicationController

  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      flash[:success] = I18n.t 'post.create'
      redirect_to posts_path
    else
      render :new
    end
  end

  def show
    @user = @post.user
  end

  def edit
  end

  def update
    @post.assign_attributes post_params
    if @post.save
      flash[:success] = I18n.t 'post.update'
      redirect_to @post
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    flash[:secondary] = I18n.t 'post.destroy'
    redirect_to posts_path
  end

  private
  def post_params
    params.require(:post).permit(:title, :body)
  end

  def set_post
    @post = Post.find_by(id: params[:id])
  end

end
