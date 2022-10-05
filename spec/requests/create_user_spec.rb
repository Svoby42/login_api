require 'rails_helper'

RSpec.describe 'Create', type: :request do
  describe 'POST /users' do
    context 'with valid parameters' do
      before do
        post '/api/v1/users', params:
          {
            full_name: "Josef Olsak",
            name: "olsak",
            email: "olsak@spsmb.cz",
            password: "jednadvatri",
            password_confirmation: "jednadvatri"
          }
      end

      it 'user gets saved' do
        expect(User.count).to eq(1)
      end

      it 'returns the full name' do
        expect(json['user']['full_name']).to eq("Josef Olsak")
      end

      it 'returns the email' do
        expect(json['user']['email']).to eq("olsak@spsmb.cz")
      end

      it 'returns the name' do
        expect(json['user']['name']).to eq("olsak")
      end
    end

    context 'with invalid parameters' do
      before do
        post '/api/v1/users', params:
          {
            full_name: "",
            name: ""
          }
      end

      it 'returns an unprocessable entity status' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end