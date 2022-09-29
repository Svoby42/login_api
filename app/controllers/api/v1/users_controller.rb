class Api::V1::UsersController < ApplicationController

  # GET /api/v1/users
  def index
    @users = User.order(name: :desc)
    render json: @users
  end

  # GET /api/v1/users/:id
  def show
    @user = User.find(params[:id])
  end

  # POST /api/v1/users
  def create
    @user = User.new(
      name: params[:user][:name],
      email: params[:user][:email],
      password: params[:user][:password],
      password_confirmation: params[:user][:password_confirmation]
    )
    if @user.save
      render json: {
        message: "Account successfully created",
        user: @user
      }, status: :created
    else
      error_array = []
      @user.errors.objects.each do |error|
        error_array << error.full_message
      end
      render json: {
        errors: error_array
      }, status: :bad_request
    end
  end

  # DELETE /api/v1/users/:id
  def destroy
    @user.delete
  end

  # PUT /api/v1/users/:id
  def update
    @user.update(params.permit(:name, :password))
  end

  private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end

  def find_user
    @user = User.find(params[:id])
  end
end
