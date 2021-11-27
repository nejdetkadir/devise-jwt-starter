class ApplicationController < ActionController::API
  respond_to :json

  include ActionController::MimeResponds

  def authenticate_user!
    return if current_user

    render json: { error: I18n.t('devise.failure.unauthenticated') }, status: :unauthorized
  end
end
