require 'rails_helper'

RSpec.describe 'Login', type: :request do
  describe 'POST /users' do
    context 'with valid credentials' do
      let!(:my_user) { FactoryBot.create(:user) }
      before do
        post '/api/v1/auth/login', params:
          {
            email: my_user.email,
            password: my_user.password
          }
      end
      it 'response contains token' do
        expect(json['token']).not_to be_empty
      end
    end

    context "with invalid credentials" do
      let!(:my_user) { FactoryBot.create(:user) }
      before do
        post '/api/v1/auth/login', params:
          {
            email: my_user.email,
            password: "wrong_password"
          }
      end
      it 'response contains error' do
        expect(json['error']).not_to be_empty
      end
    end
  end
end