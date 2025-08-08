require 'rails_helper'

RSpec.describe "Agreements", type: :request do
  describe "GET /show" do
    it "returns http success" do
      get "/agreements/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /agree" do
    it "returns http success" do
      get "/agreements/agree"
      expect(response).to have_http_status(:success)
    end
  end

end
