require 'rails_helper'

RSpec.describe 'Create', type: :request do
  describe 'POST /posts' do

    context 'as the correct user' do
      let!(:my_user) { FactoryBot.create(:user) }
      let!(:my_post) { FactoryBot.create(:post) }
      before do
        post '/api/v1/auth/login', params:
          {
            email: my_user.email,
            password: my_user.password
          }
        @token = json['token']
        delete "/api/v1/posts/#{my_post.id}", headers: { Authorization: @token }
      end

      it 'token is not empty' do
        expect(@token).not_to be_empty
      end

      it 'post got saved' do
        expect(Post.count).to eq(0)
      end

      it 'response contains successful code' do
        expect(response).to have_http_status(:success)
      end
    end

    context 'as an incorrect user' do
      let!(:my_user) { FactoryBot.create(:user) }
      let!(:another_user) { FactoryBot.create(:user) }
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
        post '/api/v1/auth/login', params:
          {
            email: another_user.email,
            password: another_user.password
          }
        @token = json['token']
        delete "/api/v1/posts/1", headers: { Authorization: @token }
      end

      it 'posts should be none' do
        expect(Post.count).to eq(1)
      end

      it 'response should be unauthorized' do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end