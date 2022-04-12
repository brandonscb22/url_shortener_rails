require 'rails_helper'
RSpec.describe LinksController, type: :controller do
  let!(:user){ create :user }
  let!(:link){ create :link, {user_id: user.id} }
  let!(:token){ AuthenticationController::jwt_encode({user_id: user.id}) }
  describe "index" do
    it "Get all links for user" do
      links = Link.where(user_id: user.id).to_a
      request.headers["Authorization"] = 'Bearer ' + token
      get :index
      expect(response).to have_http_status(:ok)
      expect(response.body).to eq(links.to_json)
    end
    it "Get all links for user without authentication" do
      get :index
      expect(response).to have_http_status(:unauthorized)
    end
  end
  describe "show" do
    it "Get link for user" do
      link_history = LinkHistory.where( link_id: link.id).to_a.count
      link_1 = Link.find_by(id:link.id ,user_id: user.id).attributes
      request.headers["Authorization"] = 'Bearer ' + token
      get :show, params: {id: link.id}
      expect(response).to have_http_status(:ok)
      expect(response.body).to eq(link_1.merge(visits: link_history).to_json)
    end
  end
  describe "create" do
    it "Create link for user" do
      request.headers["Authorization"] = 'Bearer ' + token
      post :create, params: { url: link.url }, as: :json
      expect(response).to have_http_status(:created)
    end
    it "Create link for user without authentication" do
      get :create
      expect(response).to have_http_status(:unauthorized)
    end
  end
  describe "update" do
    it "Update link for user" do
      request.headers["Authorization"] = 'Bearer ' + token
      post :update, params: { id: link.id ,url: link.url }, as: :json
      expect(response).to have_http_status(:ok)
    end
    it "Create link for user without authentication" do
      get :update, params: { id: link.id ,url: link.url }, as: :json
      expect(response).to have_http_status(:unauthorized)
    end
  end
  describe "destroy" do
    it "Create link for user" do
      request.headers["Authorization"] = 'Bearer ' + token
      post :destroy, params: { id: link.id }, as: :json
      expect(response).to have_http_status(:no_content)
    end
    it "Create link for user without authentication" do
      post :destroy, params: { id: link.id }, as: :json
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
