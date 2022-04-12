require 'rails_helper'
RSpec.describe UsersController, type: :controller do
  let!(:user_1){ create :user }
  let!(:user_2){ create :user }
  let!(:link){ create :link, {user_id: user_1.id} }
  let!(:token){ AuthenticationController::jwt_encode({user_id: user_1.id}) }
  describe "index" do
    it "Get user info" do
      user = User.find(user_1.id)
      request.headers["Authorization"] = 'Bearer ' + token
      get :show, params: { id: user_1.id}
      expect(response).to have_http_status(:ok)
      expect(response.body).to eq(user.to_json)
    end
    it "Get user info other user" do
      request.headers["Authorization"] = 'Bearer ' + token
      get :show, params: { id: user_2.id}
      expect(response).to have_http_status(:unauthorized)
    end
    it "Get user info without authentication" do
      get :show, params: { id: user_1.id}
      expect(response).to have_http_status(:unauthorized)
    end
  end

end

