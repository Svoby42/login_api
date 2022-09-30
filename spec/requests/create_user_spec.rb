require 'rails_helper'

RSpec.describe 'Create', type: :request do
  describe 'POST /users' do
    context 'with valid parameters' do
      let!(:my_user) { FactoryBot.create(:user) }

      before do
        post '/api/v1/users', params:
          { user: {
            full_name: my_user.full_name,
            name: my_user.name,
            email: my_user.email,
            password: my_user.password,
            password_confirmation: my_user.password_confirmation
          } }
      end

      it 'returns the full_name' do
        puts response.body
        expect(json['full_name']).to eq(my_user.full_name)
      end
    end
  end
end