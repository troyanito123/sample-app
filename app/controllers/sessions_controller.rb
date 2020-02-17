class SessionsController < ApplicationController

  skip_before_action :logged_in_user, except: [:destroy]
  before_action :user_login, except: [:destroy]

  def new
  end

  def create
    user = User.find_by(email: session_params[:email])
    if( user && user.authenticate(session_params[:password]))
      log_in(user)
      flash[:success] = I18n.t 'user.login'
      redirect_to posts_path
    else
      flash[:danger] = I18n.t 'user.errors.login'
      render :new
    end
  end

  def destroy
    log_out
    flash[:secondary] = I18n.t 'user.logout'
    redirect_to root_path
  end

  private
  def session_params
    params.require(:session).permit(:email, :password)
  end

  def user_login
    if !current_user.nil?
      flash[:warning] = I18n.t 'logut'
      redirect_back fallback_location: root_path
    end
  end
end
