class Api::V1::PostsController < ApplicationController
  before_action :can_post, except: %i[ index show ]
  before_action :is_owner?, only: %i[ destroy ]

  # GET /api/v1/posts
  def index
    @posts = Post.all.includes(:user)
    render json: @posts, status: :ok
  end

  # GET /api/v1/posts/:id
  def show
    @post = Post.find(params[:id])
    render json: @post, status: :ok
  end

  # POST /api/v1/posts
  def create
    create_post_from_params
    if @post.save
      render json: {
        message: "Post successfully submitted",
        title: @post[:title],
        id: @post[:id]
      }, status: :created
    else
      generate_errors
    end
  end

  # DELETE /api/v1/posts/:id
  def destroy
    if @post.destroy
      render json: {
        message: "Post successfully deleted"
      }, status: :ok
    else
      generate_errors
    end
  end

  def update

  end

  private

  def create_post_from_params
    @post = Post.new(
      title: params[:title],
      content: params[:content],
      user_id: @current_user[:id]
    )
  end

  def generate_errors
    error_array = []
    @post.errors.objects.each do |error|
      error_array << error.full_message
    end
    render json: {
      error: error_array
    }, status: :unprocessable_entity
  end
end
