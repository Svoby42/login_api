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
        expect(user.reload.full_name).to eq("Josef Olsak")
      end

      it "should return successful status code" do
        expect(response).to have_http_status(:success)
      end
    end

    context 'with wrong api key' do
      before do
        patch "/api/v1/users/#{user.id}",
              params: {
                full_name: "Josef Olsak",
              },
              headers: { Authorization: "bruh" }
      end

      it "should return unauthorized status code" do
        expect(response).to have_http_status(:unauthorized)
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
        expect(another_user.reload.full_name).to eq("Karel Havlickovic")
      end

      it "should return successful status code" do
        expect(response).to have_http_status(:success)
      end
    end

    context 'without admin role for another user' do
      before do
        post "/api/v1/auth/login",
             params: { email: user.email, password: user.password }
        @token = json['token']
        patch "/api/v1/users/#{another_user.id}",
              params: { full_name: "Karel Havlickovic" }, headers: { Authorization: @token }
      end

      it "full_name should be the same" do
        expect(another_user.reload.full_name).to eq(another_user.full_name)
      end

      it "should return unauthorized" do
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'change password as the current user' do
      before do
        post "/api/v1/auth/login",
             params: { email: user.email, password: user.password }
        @token = json['token']
        patch "/api/v1/users/#{user.id}",
              params:
                {
                  old_password: user.password,
                  password: "brekeke",
                  password_confirmation: "brekeke"
              }, headers: { Authorization: @token }
      end

      it "password should change" do
        expect(response).to have_http_status(:success)
      end

      it "login with changed password" do
        post "/api/v1/auth/login",
             params: { email: user.email, password: "brekeke" }
        expect(response).to have_http_status(:success)
      end
    end

    context 'change password as someone else' do
      before do
        post "/api/v1/auth/login",
             params: { email: user.email, password: user.password }
        @token = json['token']
        patch "/api/v1/users/#{another_user.id}",
              params:
                {
                  old_password: another_user.password,
                  password: "brekeke",
                  password_confirmation: "brekeke"
                }, headers: { Authorization: @token }
      end

      it "should return unauthorized" do
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'change password without old password' do
      before do
        post "/api/v1/auth/login",
             params: { email: user.email, password: user.password }
        @token = json['token']
        @original_password = user.password
        patch "/api/v1/users/#{user.id}",
              params:
                {
                  password: "brekeke",
                  password_confirmation: "brekeke"
                }, headers: { Authorization: @token }
      end

      it "should return bad request" do
        expect(response).to have_http_status(:bad_request)
      end

      it "password should stay the same" do
        expect(user.password).to eq(@original_password)
      end
    end

    context 'change password with wrong old password' do
      before do
        post "/api/v1/auth/login",
             params: { email: user.email, password: user.password }
        @token = json['token']
        @original_password = user.password
        patch "/api/v1/users/#{user.id}",
              params:
                {
                  old_password: "wrongpassword",
                  password: "brekeke",
                  password_confirmation: "brekeke"
                }, headers: { Authorization: @token }
      end

      it "should return bad request" do
        expect(response).to have_http_status(:unauthorized)
      end

      it "password should stay the same" do
        expect(user.password).to eq(@original_password)
      end
    end
  end
end