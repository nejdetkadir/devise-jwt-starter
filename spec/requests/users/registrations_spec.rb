require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe "Devise::Registrations", type: :request do
  let(:headers) { { 'Accept' => 'application/json', 'Content-Type' => 'application/json' } }

  describe "POST /users" do
    describe "with unique email/password" do
      before do
        post user_registration_path, params: {
          user: {
            email: Faker::Internet.email,
            password: "123456789",
            password_confirmation: "123456789"
          }
        }.to_json, headers: headers
      end

      it "returns status code 401" do
        expect(response).to have_http_status(:unauthorized)
      end

      it "returns confirmation message" do
        expect(JSON.parse(response.body)["error"]).to eq(I18n.t('devise.failure.unconfirmed'))
      end
    end

    describe "with different passwords" do
      before do
        post user_registration_path, params: {
          user: {
            email: Faker::Internet.email,
            password: "123456789",
            password_confirmation: "!123456789!"
          }
        }.to_json, headers: headers
      end

      it "returns status code 422" do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "returns errors of resource" do
        expect(JSON.parse(response.body)["password_confirmation"]).not_to eq(nil)
      end
    end

    describe "with same email" do
      before do
        post user_registration_path, params: {
          user: {
            email: create(:user).email,
            password: "123456789",
            password_confirmation: "123456789"
          }
        }.to_json, headers: headers
      end

      it "returns status code 422" do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "returns errors of resource" do
        expect(JSON.parse(response.body)["email"]).not_to eq(nil)
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
