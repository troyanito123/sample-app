class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: session_params[:email])
    if( user && user.authenticate(session_params[:password]))
      flash[:success] = I18n.t 'user.login'
      redirect_to static_pages_home_path
    else
      flash[:danger] = I18n.t 'user.errors.login'
      render :new
    end
  end

  private
  def session_params
    params.require(:session).permit(:email, :password)
  end
end
