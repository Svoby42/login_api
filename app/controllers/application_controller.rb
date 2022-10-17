class ApplicationController < ActionController::API

  def not_found
    render json: { error: 'not_found' }
  end

  def authorize_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    if header.eql?(ENV['API_KEY'])
      unless params[:id].nil?
        begin
          @current_user = User.find(params[:id])
        rescue ActiveRecord::RecordNotFound => e
          render json: { errors: e.message }, status: :unauthorized
        end
      end
    else
      begin
        unless params[:id].nil?
          @current_user = User.find(params[:id])
        end
        @decoded = JsonWebToken.decode(header)
        unless @current_user.nil?
          if @current_user[:email].eql?(@decoded[:email]) && !@decoded[:role].eql?("ADMIN")
            @current_user
          elsif @decoded[:role].eql?("ADMIN")
            @current_user
          else
            render json: { errors: "Insufficient rights" }, status: :unauthorized
          end
        end
      rescue ActiveRecord::RecordNotFound => e
        render json: { errors: e.message }, status: :unauthorized
      rescue JWT::DecodeError => e
        render json: { errors: e.message }, status: :unauthorized
      end
    end
  end

  def can_post
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    @decoded = JsonWebToken.decode(header)
    begin
      @current_user = User.find(@decoded[:id])
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end

  def is_owner?
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    @decoded = JsonWebToken.decode(header)
    @post = Post.find(params[:id])
    unless @post[:user_id] == @decoded[:id]
      render json: { error: "Wrong user" }, status: :unauthorized
    end
  end
end
