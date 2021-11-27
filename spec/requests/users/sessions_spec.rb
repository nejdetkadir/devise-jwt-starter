require 'rails_helper'
require 'devise/jwt/test_helpers'

# rubocop:disable Metrics/BlockLength
RSpec.describe "Devise::Sessions", type: :request do
  let(:headers) { { 'Accept' => 'application/json', 'Content-Type' => 'application/json' } }
  let(:user) { create(:user) }

  before { user.confirm } # confirm manually

  describe "POST /sign_in" do
    describe "with correct email/password" do
      before do
        post user_session_path, params: {
          user: {
            email: user.email,
            password: user.password
          }
        }.to_json, headers: headers
      end

      it "returns status code 200" do
        expect(response).to have_http_status(:ok)
      end

      it "returns authorization bearer token on headers" do
        expect(response.headers["Authorization"]).not_to eq(nil)
      end
    end

    describe "with incorrect email or password" do
      before do
        post user_session_path, params: {
          user: {
            email: user.email,
            password: "!#{user.password}!"
          }
        }.to_json, headers: headers
      end

      it "returns status code 401" do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe "DELETE /sign_out" do
    describe "with authorization bearer token" do
      before do
        delete destroy_user_session_path, headers: Devise::JWT::TestHelpers.auth_headers(headers, user)
      end

      it "returns status code 204" do
        expect(response).to have_http_status(:no_content)
      end

      it "adds token to JWT denylist" do
        expect(JwtDenylist.count).to eq(1)
      end
    end

    describe "without authorization bearer token" do
      before do
        delete destroy_user_session_path, headers: headers
      end

      it "returns status code 204" do
        expect(response).to have_http_status(:no_content)
      end

      it "do not adds token to JWT denylist" do
        expect(JwtDenylist.count).to eq(0)
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
