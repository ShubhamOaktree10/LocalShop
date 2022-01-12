class ApplicationController < ActionController::Base
	helper_method :current_user
	before_action :require_user, only: [:craete]
	def require_user
    redirect_to '/login' unless current_user
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
