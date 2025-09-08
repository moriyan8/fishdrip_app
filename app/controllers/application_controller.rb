class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :render_404
  rescue_from StandardError, with: :render_500

  allow_browser versions: :modern
  helper_method :current_user
  helper_method :user_signed_in?
  before_action :authenticate_user!
  before_action :check_policy_agreement

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

  private

  def check_policy_agreement
    if current_user && !current_user.agreed_to_policy? && !on_policy_agreement_page?
      redirect_to policy_agreement_path
    end
  end

  def on_policy_agreement_page?
    controller_name == "agreements" && action_name == "show"
  end

  def render_404(exception = nil)
    logger.error("404 Not Found: #{exception.message}") if exception
    render file: Rails.root.join("public/404.html"), status: :not_found, layout: false
  end

  def render_500(exception = nil)
    logger.error("500 Internal Server Error: #{exception.message}")
    logger.error(exception.backtrace.join("\n")) if exception
    render file: Rails.root.join("public/500.html"), status: :internal_server_error, layout: false
  end
end
