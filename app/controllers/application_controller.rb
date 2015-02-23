class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  before_filter :login_from_api_token
  before_filter :require_login

  private

  def login_from_api_token
    if request.headers["X-Beerventory-Token"]
      @current_user = User.where(api_token: request.headers["X-Beerventory-Token"]).first
      auto_login(@current_user) if @current_user
    end
  end

  def not_authenticated
    respond_to do |format|
      format.html { redirect_to new_session_url }
      format.json { render nothing: true, status: 401 }
    end
  end
end
