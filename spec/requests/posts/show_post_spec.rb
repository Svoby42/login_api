RSpec.describe 'Show', type: :request do
  describe "GET /users/:id" do
    let!(:my_user) { FactoryBot.create(:user) }
    let!(:my_post) { FactoryBot.create(:post, user_id: my_user.id) }
    context "in normal situation" do
      before do
        get "/api/v1/posts/#{my_post.id}"
      end

      it 'response should be success' do
        expect(response).to have_http_status(:success)
      end
    end
  end
end