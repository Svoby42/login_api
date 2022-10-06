require 'rails_helper'

RSpec.describe 'Validate', type: :request do
  describe 'POST /validate/email' do
    context 'with taken email' do
      let!(:my_user) { FactoryBot.create(:user) }
      before do
        post '/api/v1/validate/email', params:
          {
            email: my_user.email
          }
      end

      it 'user gets saved' do
        expect(User.count).to eq(1)
      end

      it 'returns a conflict status' do
        expect(response).to have_http_status(:conflict)
      end
    end

    context 'with not taken email' do
      before do
        post '/api/v1/validate/email', params:
          {
            email: "example@email.com"
          }
      end

      it 'returns a conflict status' do
        expect(response).to have_http_status(:ok)
      end
    end
  end
end