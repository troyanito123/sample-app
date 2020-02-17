class UsersController < ApplicationController

  skip_before_action :logged_in_user, except: [:index]
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

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
