class Api::V1::UsersController < ApplicationController
  before_action :authorize_request, except: :create
  before_action :is_admin?, only: %i[index update destroy]

  # GET /api/v1/users
  def index
    @users = User.order(name: :desc)
    render json: @users, status: :ok
  end

  # GET /api/v1/users/:id
  def show
    @user = User.find(params[:id])
    render json: {
      user: @user
    }, status: :ok              # This is where the User_Serializer is used
  end

  # POST /api/v1/users
  def create
    create_user_from_params
    if @user.save
      render json: {
        message: "Account successfully created, check your inbox",
        user: @user
      }, status: :created
      # UserMailer.welcome(@user).deliver
    else
      generate_errors
    end
  end

  # DELETE /api/v1/users/:id
  def destroy
    get_current_user
    if @user.destroy
      render json: {
        message: "User successfully deleted"
      }, status: :ok
    else
      generate_errors
    end
  end

  # PATCH /api/v1/users/:id
  def update
    get_current_user
    @user.update(params.permit(:full_name, :password, :password_confirmation))
    if params[:old_password].nil?
      if @user.save
        render json: {
          message: "User successfully updated"
        }, status: :ok
      else
        generate_errors
      end
    elsif params[:old_password].present?
      if params[:password].eql?(params[:password_confirmation])
        @user.password = params[:password]
        if @user.save
          render json: {
            message: "Password successfully updated"
          }, status: :ok
        else
          generate_errors
        end
      else
        render json: {
          message: "Password & Password confirmation don't match"
        }, status: :bad_request
      end
    else
      render json: {
        message: "The current password is different"
      }, status: :bad_request
    end
  end

  private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end

  def create_user_from_params
    @user = User.new(
      full_name: params[:full_name],
      name: params[:name],
      email: params[:email],
      password: params[:password],
      password_confirmation: params[:password_confirmation],
      role: "USER"
    )
  end

  def get_current_user
    @user = @current_user
    rescue ActiveRecord::RecordNotFound
      render json: { errors: "User not found" }, status: :not_found
  end

  def generate_errors
    error_array = []
    @user.errors.objects.each do |error|
      error_array << error.full_message
    end
    render json: {
      error: error_array
    }, status: :unprocessable_entity
  end
end
