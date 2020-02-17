class UsersController < ApplicationController

  skip_before_action :logged_in_user, only: [:new, :create]
  before_action :set_user, only: [:edit, :update]
  before_action -> { authorize @user || User }

  def index
    @users = User.all
  end

  def new
    @user = User.new
    @roles = Role.all
  end

  def create
    @roles = Role.all
    @user = User.new(user_params)
    if logged_in? && current_user.admin?
      @user.role = Role.find(params[:user][:role])
    else
      @user.role = Role.find_by(code: "USER")
    end
    if @user.save
      flash[:success] = I18n.t 'user.create'
      redirect_back fallback_location: login_path
    else
      render :new
    end
  end

  def edit
    @roles = Role.all
  end

  def update
    @roles = Role.all
    @user.assign_attributes user_params
    if current_user.admin?
      @user.role = Role.find(params[:user][:role])
    end

    if @user.save
      flash[:success] = I18n.t 'user.update'
      if current_user.admin?
        redirect_to users_path
      else
        redirect_to posts_path
      end
    else
      render :edit
    end

  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :avatar)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
