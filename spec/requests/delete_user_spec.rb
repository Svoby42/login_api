require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe "DELETE /users/:id" do
    let!(:user) { FactoryBot.create(:user) }

    context "with api key" do
      before do
        delete "/api/v1/users/#{user.id}", headers: { Authorization: ENV['API_KEY'] }
      end

      it 'returns successful status code' do
        expect(response).to have_http_status(:success)
      end
    end

    context "without admin role" do   # TOHLE PROJÍT NEMÁ, USER NENÍ ADMIN, NEMŮŽE SE SÁM SMAZAT
      before do
        post '/api/v1/auth/login', params:
          {
            email: user.email,
            password: user.password
          }
        delete "/api/v1/users/#{user.id}", headers: { Authorization: json['token'] }
      end
      it 'returns unauthorized status code' do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
