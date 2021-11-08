class Api::BaseController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :authorize_request

  private

  def authorize_request
    AuthorizationService.new(request.headers).authenticate_request!
  rescue JWT::VerificationError, JWT::DecodeError
    render json: { errors: ['Not Authenticated'] }, status: :unauthorized
  end
end
