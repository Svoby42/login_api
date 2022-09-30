class Api::V1::AuthenticationController < ApplicationController
  before_action :authorize_request, except: :login

  # POST /api/v1/auth/login
  def login
    @user = User.find_by_email(params[:email])
    if @user&.authenticate(params[:password])
      token = JsonWebToken.encode(user_id: @user.id, role: @user.role)
      time = Time.now + 24.hours.to_i
      render json: { token: token, exp: time.strftime("%d.%m.%Y %H:%M"),
                     email: @user.email }, status: :ok
    else
      render json: { error: "Wrong credentials" }, status: :unauthorized
    end
  end

  private

  def login_params
    params.permit(:email, :password)
  end
end
