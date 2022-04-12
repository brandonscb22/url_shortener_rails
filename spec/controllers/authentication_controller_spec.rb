require 'rails_helper'
RSpec.describe AuthenticationController, type: :controller do
  let!(:password_generated){ Faker::Internet.password }
  let!(:user_1){ create :user, password: password_generated }

  describe "index" do
    it "Login test" do
      get :login, params: { email: user_1.email, password: password_generated }
      expect(response).to have_http_status(:ok)
    end
    it "Login failed" do
      get :login, params: { email: user_1.email, password: password_generated + '1' }
      expect(response).to have_http_status(:unauthorized)
    end
  end
  describe "index" do
    it "Sign up test" do
      user_test = {
        name: Faker::Internet.name,
        username: Faker::Internet.username,
        email: Faker::Internet.email,
        password: Faker::Internet.password
      }
      get :sign_up, params: user_test
      expect(response).to have_http_status(:created)
    end
    it "Login failed" do
      user_test = {
        name1: Faker::Internet.name,
        username1: Faker::Internet.username,
        email1: Faker::Internet.email,
        password1: Faker::Internet.password
      }
      get :sign_up, params: user_test
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
