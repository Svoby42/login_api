require 'rails_helper'

RSpec.describe 'Create', type: :request do
  describe 'POST /users' do
    context 'with valid parameters' do
      let!(:my_user) { FactoryBot.create(:user) }

      before do
        post '/api/v1/auth/login', params:
          {
            email: my_user.email,
            password: my_user.password
          }
      end

      it 'response contians token' do
        expect(json['token']).not_to be_empty
      end
    end
  end
end