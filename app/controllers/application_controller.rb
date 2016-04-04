class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token, if: :api_request?
  before_action :authorize_access!

protected
  def api_request?
    params[:controller].split("/").first == "api"
  end

  def authorize_access!
    return unless api_request?
    head :unauthorized unless params[:access_token] == ENV["API_ACCESS_TOKEN"]
    return false
  end
end
