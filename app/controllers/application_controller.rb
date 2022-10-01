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
        @current_user = User.find(params[:id])
        @decoded = JsonWebToken.decode(header)
        if @current_user[:email].eql?(@decoded[:email])
          @current_user = User.find(@decoded[:user_id])
        elsif @decoded[:role].eql?("ADMIN")
          @current_user = User.find(params[:id])
        end
      rescue ActiveRecord::RecordNotFound => e
        render json: { errors: e.message }, status: :unauthorized
      rescue JWT::DecodeError => e
        render json: { errors: e.message }, status: :unauthorized
      end
    end
  end

  def is_admin?
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    if header.eql?(ENV['API_KEY'])
      true
    else
      @decoded = JsonWebToken.decode(header)
      unless @decoded[:role].eql?("ADMIN")
        render json: {
          error: "Insufficient rights"
        }, status: :unauthorized
      end
    end
  end
end
