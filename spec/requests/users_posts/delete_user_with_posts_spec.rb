require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe "GET /users/:id" do
    let!(:user) { FactoryBot.create(:user) }
    context "with api key" do
      before do
        post '/api/v1/auth/login', params:
          {
            email: user.email,
            password: user.password
          }
        @token = json['token']
        get "/api/v1/users/#{user.id}", headers: { Authorization: @token }
      end

      it 'returns successful status code' do
        expect(response).to have_http_status(:success)
      end

      it 'returns empty posts array' do
        expect(json['posts']).to match_array([])
      end

      describe "creates a post" do
        before do
          post '/api/v1/posts', params: {
            title: "Titulek random",
            content: "Random content",
            slug: Faker::Internet.slug(words: "Titulek random")
          }, headers: { Authorization: @token }
        end

        it 'returns successful status code' do
          expect(response).to have_http_status(:success)
        end

        it 'posts should not be empty' do
          expect(Post.count).to eq(1)
        end

        it 'returns not empty posts array' do
          get "/api/v1/users/#{user.id}", headers: { Authorization: @token }
          expect(json['posts']).not_to be_empty
        end

        describe "deletes the user and the posts" do
          before do
            delete "/api/v1/users/#{user.id}", headers: { Authorization: @token }
          end

          it 'returns successful status code' do
            expect(response).to have_http_status(:success)
          end

          it 'posts should be deleted' do
            expect(Post.count).to eq(0)
          end
        end
      end
    end
  end
end
