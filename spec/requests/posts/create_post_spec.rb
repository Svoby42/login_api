require 'rails_helper'

RSpec.describe 'Create', type: :request do
  describe 'POST /posts' do

    context 'with valid information' do
      let!(:my_user) { FactoryBot.create(:user) }
      before do
        post '/api/v1/auth/login', params:
          {
            email: my_user.email,
            password: my_user.password
          }
        @token = json['token']
        post '/api/v1/posts', params: {
          title: "Titulek random",
          content: "Random content",
        }, headers: { Authorization: @token }
      end

      it 'token is not empty' do
        expect(@token).not_to be_empty
      end

      it 'post got saved' do
        expect(Post.count).to eq(1)
      end

      it 'response contains successful code' do
        expect(response).to have_http_status(:success)
      end
    end

    context 'with short content' do
      let!(:my_user) { FactoryBot.create(:user) }
      before do
        post '/api/v1/auth/login', params:
          {
            email: my_user.email,
            password: my_user.password
          }
        @token = json['token']
        post '/api/v1/posts', params: {
          title: "Titulek random",
          content: "kratky",
        }, headers: { Authorization: @token }
      end
      it 'post doesnt get saved' do
        expect(Post.count).to eq(0)
      end

      it 'response contains successful code' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end