require 'rails_helper'

RSpec.describe 'Validate', type: :request do
  describe 'POST /validate/name' do
    context 'with taken' do
      let!(:my_user) { FactoryBot.create(:user) }
      before do
        post '/api/v1/validate/name', params:
          {
            name: my_user.name
          }
      end

      it 'user gets saved' do
        expect(User.count).to eq(1)
      end

      it 'returns a conflict status' do
        expect(response).to have_http_status(:conflict)
      end
    end
  end
end