require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe "Users::Confirmations", type: :request do
  let(:headers) { { 'Accept' => 'application/json', 'Content-Type' => 'application/json' } }
  let(:user) { create(:user) }

  it "send email about confirmation when user signed up" do
    user # use for creating new user with let

    expect(Devise.mailer.deliveries.count).to eq(1)
  end

  describe "send confirmation with valid email" do
    before { confirm_with_email }

    it "returns status code 200" do
      expect(response).to have_http_status(:ok)
    end

    it "must send an email about confirmations" do
      expect(Devise.mailer.deliveries.count).to eq(2)
    end
  end

  describe "send confirmation with invalid email" do
    before do
      post user_confirmation_path, params: {
        user: {
          email: "tester#{user.email}"
        }
      }.to_json, headers: headers
    end

    it "returns status code 422" do
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "POST /confirmation" do
    describe "with valid confirmation token" do
      before do
        confirm_with_email

        get user_confirmation_path, params: {
          confirmation_token: crawl_confirmation_token_from_email
        }, headers: headers
      end

      it "returns status code 200" do
        expect(response).to have_http_status(:ok)
      end

      it "must confirm user" do
        expect(User.first.confirmed?).to eq(true)
      end
    end

    describe "with invalid confirmation token" do
      before do
        confirm_with_email

        get user_confirmation_path, params: {
          confirmation_token: "!#{crawl_confirmation_token_from_email}!"
        }, headers: headers
      end

      it "returns status code 422" do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  def confirm_with_email
    post user_confirmation_path, params: {
      user: {
        email: user.email
      }
    }.to_json, headers: headers
  end

  def crawl_confirmation_token_from_email
    Devise.mailer.deliveries.last.as_json["body"]["raw_source"].split("confirmation_token=").last.split('">').first
  end
end
# rubocop:enable Metrics/BlockLength
