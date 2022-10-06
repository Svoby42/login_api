require 'rails_helper'

RSpec.describe 'Show', type: :request do
  describe "GET /users/:id" do
    let!(:admin_user) { FactoryBot.create(:user) }
    let!(:not_admin) { FactoryBot.create(:user) }

    context "as admin" do
      before do
        admin_user.role = "ADMIN"
        admin_user.save!
        post "/api/v1/auth/login", params: {
          email: admin_user.email,
          password: admin_user.password
        }
        @token = json['token']
        get "/api/v1/users/#{not_admin.id}", headers: {Authorization: @token}
      end

      it 'user has admin role' do
        expect(admin_user.role).to eq("ADMIN")
      end

      it 'should return user' do
        expect(response).to have_http_status(:success)
      end
    end

    context "not as admin" do
      before do
        post "/api/v1/auth/login", params: {
          email: not_admin.email,
          password: not_admin.password
        }
        @token = json['token']
        get "/api/v1/users/#{admin_user.id}", headers: {Authorization: @token}
      end

      it 'user has user role' do
        expect(not_admin.role).to eq("USER")
      end

      it 'should return unauthorized' do
        expect(response).to have_http_status(:unauthorized)
      end
    end

  end
end