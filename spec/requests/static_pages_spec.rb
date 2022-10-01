require 'rails_helper'

RSpec.describe "StaticPages", type: :request do
  describe "GET /landing_page" do
    it "returns http success" do
      get "/landing_page"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /privacy_policy" do
    it "returns http success" do
      get "/privacy_policy"
      expect(response).to have_http_status(:success)
    end
  end

end
