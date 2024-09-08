class ApplicationController < ActionController::API
  # protect_from_forgery with: :exception

  def current_user
    @current_user ||= Model.find_by(id: session[:user_id])
  end

  def authenticate_user!
    if current_user.nil?
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end
end
