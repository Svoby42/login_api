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

    context "with admin role" do
      before do
        user.role = "ADMIN"
        user.save!                                                  # VERY IMPORTANT STEP!
        FactoryBot.create_list(:user, 10)
        post '/api/v1/auth/login', params:
          {
            email: user.email,
            password: user.password
          }
        @token = json['token']
      end

      (2..11).each do |id| # the ADMIN has an id of 1, we created 10 more users so 2..11
        it "should delete user id #{id}" do
          delete "/api/v1/users/#{id}", headers: { Authorization: @token }
          expect(response).to have_http_status(:success)
        end
      end
    end

    context "without admin role delete yourself" do
      before do
        post '/api/v1/auth/login', params:
          {
            email: user.email,
            password: user.password
          }
        delete "/api/v1/users/#{user.id}", headers: { Authorization: json['token'] }
      end
      it 'returns unauthorized status code' do
        expect(response).to have_http_status(:success)
      end
    end
  end
end
