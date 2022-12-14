class Api::V1::AuthenticationController < ApplicationController
  before_action :authorize_request, except: :login

  # POST /api/v1/auth/login
  def login
    @user = User.find_by_email(params[:email])
    unless @user.nil?
      if @user&.authenticate(params[:password])
        token = JsonWebToken.encode(id: @user.id, role: @user.role, email: @user.email)
        time = Time.now + 24.hours.to_i
        render json: { token: token, exp: time.strftime("%d.%m.%Y %H:%M") }, status: :ok
      else
        render json: {
          error: "Wrong credentials"
        }, status: :unauthorized
      end
    else
      render json: { error: "User doesn't exist" }, status: :not_found
    end
  end

  private

  def login_params
    params.permit(:email, :password)
  end
end
