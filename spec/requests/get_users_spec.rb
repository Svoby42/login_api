require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /users' do
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
end