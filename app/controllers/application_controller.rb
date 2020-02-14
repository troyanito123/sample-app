class ApplicationController < ActionController::Base

  include SessionsHelper

  before_action :logged_in_user

  def logged_in_user
    unless logged_in?
      flash[:danger] = I18n.t 'restricted_page'
      redirect_to login_path
    end
  end

end
