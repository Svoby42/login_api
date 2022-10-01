require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe "PATCH /users/:id" do
    let!(:user) { FactoryBot.create(:user) }
    let!(:another_user) { FactoryBot.create(:user) }

    context 'with api key' do
      before do
        patch "/api/v1/users/#{user.id}",
              params: {
                full_name: "Josef Olsak",
              },
              headers: { Authorization: ENV['API_KEY'] }
      end

      it "name should be Pepa Olsak" do
        puts response.body
        expect(user.reload.full_name).to eq("Josef Olsak")
      end

      it "should return successful status code" do
        expect(response).to have_http_status(:success)
      end
    end

    context 'with admin role' do
      before do
        user.role = "ADMIN"
        user.save!
        post "/api/v1/auth/login",
             params: { email: user.email, password: user.password }
        @token = json['token']
        patch "/api/v1/users/#{another_user.id}",
              params: { full_name: "Karel Havlickovic" }, headers: { Authorization: @token }
      end

      it "name should be Karel Havlickovic" do
        puts response.body
        expect(another_user.reload.full_name).to eq("Karel Havlickovic")
      end

      it "should return successful status code" do
        expect(response).to have_http_status(:success)
      end
    end
  end
end