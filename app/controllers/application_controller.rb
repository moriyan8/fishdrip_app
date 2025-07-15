class ApplicationController < ActionController::Base
  allow_browser versions: :modern
  helper_method :current_user
  helper_method :user_signed_in?
  before_action :authenticate_user!

  def user_signed_in?
    current_user.present?
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def authenticate_user!
    unless user_signed_in?
      redirect_to root_path, alert: "ログインが必要です"
    end
  end
end
