require 'rails_helper'
RSpec.describe LinksController, type: :controller do
  let(:user){ create :user }
  let(:link){ create :link, {user_id: user.id} }
  let(:token){ AuthenticationController::jwt_encode({user_id: user.id}) }
  describe "index" do
    it "Get all links for user" do
      links = Link.where(user_id: user.id).to_a
      request.headers["Authorization"] = 'Bearer ' + token
      get :index
      expect(response).to have_http_status(:ok)
      expect(response.body.should).to eq(links.to_json)
    end
    it "Get all links for user without authentication" do
      get :index
      expect(response).to have_http_status(:unauthorized)
    end
  end
  describe "create" do
    it "Create link for user" do
      links = Link.where(user_id: user.id).to_a
      request.headers["Authorization"] = 'Bearer ' + token
      post :create, params: { url: link.url }, as: :json
      expect(response).to have_http_status(:created)
    end
    it "Create link for user without authentication" do
      get :create
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
