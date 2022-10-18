RSpec.describe 'Show', type: :request do
  describe "GET /posts" do
    context "in normal situation" do
      let!(:my_user) { FactoryBot.create(:user) }
      let!(:my_post) { FactoryBot.create_list(:post, 10, user_id: my_user.id) }
      before do
        get "/api/v1/posts"
      end

      it 'response should be success' do
        expect(response).to have_http_status(:success)
      end

      it 'there should be some posts' do
        expect(Post.count).to eq(10)
      end
    end
  end
end