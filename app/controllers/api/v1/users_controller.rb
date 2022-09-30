class Api::V1::UsersController < ApplicationController
  before_action :authorize_request, except: :create

  # GET /api/v1/users
  def index
    @users = User.order(name: :desc)
    render json: @users, status: :ok
  end

  # GET /api/v1/users/:id
  def show
    @user = User.find(params[:id])
    render json: @user, status: :ok              # This is where the User_Serializer is used
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
        error: error_array
      }, status: :bad_request
    end
  end

  # DELETE /api/v1/users/:id
  def destroy
    @user.destroy
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
    rescue ActiveRecord::RecordNotFound
      render json: { errors: "User not found" }, status: :not_found
  end
end
