require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /users' do
    context 'with api key' do
      before do
        FactoryBot.create_list(:user, 10)
        get '/api/v1/users', headers: {Authorization: ENV['API_KEY']}
      end

      it 'returns all users' do
        expect(json.size).to eq(10)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(:success)
      end
    end

    context 'without api key' do
      before do
        FactoryBot.create_list(:user, 10)
        get '/api/v1/users'
      end

      it 'returns unauthorized' do
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'as admin' do
      let!(:my_user) { FactoryBot.create(:user) }
      before do
        my_user.role = "ADMIN"
        my_user.save!
        post '/api/v1/auth/login', params:
          {
            email: my_user.email,
            password: my_user.password
          }
        @token = json['token']
      end

      it 'user gets saved' do
        expect(User.count).to eq(1)
      end

      it 'user has admin role' do
        expect(my_user.role).to eq("ADMIN")
      end

      it 'response contains JWT' do
        expect(json['token']).not_to be_empty
      end

      it 'should return all users' do
        get '/api/v1/users', headers: {Authorization: @token}
        expect(response).to have_http_status(:success)
      end
    end
  end
end