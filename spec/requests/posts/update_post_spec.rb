require 'rails_helper'

RSpec.describe "Posts", type: :request do
  describe "PATCH /posts/:id" do
    let!(:user) { FactoryBot.create(:user) }
    let!(:my_post) { FactoryBot.create(:post) }
    before do
      post "/api/v1/auth/login", params: {
        email: user.email,
        password: user.password
      }
      @token = json['token']
      patch "/api/v1/posts/#{my_post.id}", params: {
        title: "Nejaky novy title",
        content: "Nejaky novy content"
      }, headers: { Authorization: @token }
    end

    it 'response should be ok' do
      expect(response).to have_http_status(:success)
    end

    it 'title should change' do
      expect(my_post.reload.title).to eq("Nejaky novy title")
    end

    it 'content should change' do
      expect(my_post.reload.content).to eq("Nejaky novy content")
    end
  end
end