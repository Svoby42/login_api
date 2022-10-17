require 'rails_helper'

RSpec.describe "Posts", type: :request do
  describe "POST /posts" do
    context 'with valid parameters' do
      let!(:my_user) { FactoryBot.create(:user) }
      before do
        post '/api/v1/auth/login', params:
          {
            email: my_user.email,
            password: my_user.password
          }
        @token = json['token']
        post '/api/v1/posts', params: {
          title: "Titulek",
          content: "Skakal pes pres oves",
        }, headers: { Authorization: @token }
      end
    end

    it "post gets saved" do
      expect(Post.count).to eq(1)
    end
  end
end
