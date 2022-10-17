class Api::V1::PostsController < ApplicationController
  before_action :authorize_request

  def index

  end

  def show

  end

  def create
    create_post_from_params
    if @post.save
      render json: {
        message: "Post successfully submitted",
        title: @post[:title]
      }, status: :created
    end
  end

  def destroy

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
