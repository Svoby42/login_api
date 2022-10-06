class Api::V1::ValidationController < ApplicationController

  # POST /api/v1/validate/email
  def validate_email
    if User.find_by_email(params[:email])
      render json: {
        message: "Email již někdo použil"
      }, status: :conflict
    else
      render json: {
        message: "Email je volný"
      }, status: :ok
    end
  end

  # POST /api/v1/validate/name
  def validate_username
    if User.find_by_name(params[:name])
      render json: {
        message: "Toto uživatelské jméno již existuje"
      }, status: :conflict
    else
      render json: {
        message: "Uživatelské jméno je volné"
      }, status: :ok
    end
  end
end
