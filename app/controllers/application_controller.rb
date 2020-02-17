class ApplicationController < ActionController::Base

  include SessionsHelper
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  before_action :logged_in_user

  def logged_in_user
    unless logged_in?
      flash[:danger] = I18n.t 'restricted_page'
      redirect_to login_path
    end
  end

  def user_not_authorized
    flash[:warning] = "Access denied."
    redirect_back fallback_location: posts_path
  end

end
