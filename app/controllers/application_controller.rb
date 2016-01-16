class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user,:user_signed_in?,:authenticate_user!,:require_admin
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def user_signed_in?
    current_user != nil
  end

  def authenticate_user!
    unless user_signed_in?
      redirect_to root_path , notice:'請先登入'
    end
  end

  def require_login
    unless current_user
      render '/alert/not_login'
    #redirect_to root_path
    end
  end

  def require_admin
    unless current_user.identity == 1
      render '/alert/require_admin'
    #redirect_to root_path
    end
  end
end
