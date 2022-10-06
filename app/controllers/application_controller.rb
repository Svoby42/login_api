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
          end
        end
      rescue ActiveRecord::RecordNotFound => e
        render json: { errors: e.message }, status: :unauthorized
      rescue JWT::DecodeError => e
        render json: { errors: e.message }, status: :unauthorized
      end
    end
  end
end
