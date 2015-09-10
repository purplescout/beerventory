require "rails_helper"

describe "Sessions API" do
  let(:default_headers) do { "Accept" => "application/json" } end
  let(:user) { User.make!(name: "Mr Test", email: "test@example.com", password: "lolwut") }

  before do
    user.organizations << Organization.make!(name: "ÖeG")
    user.organizations << Organization.make!(name: "Excons")
  end

  describe "logging in" do
    it "succeeds when using correct email and password" do
      post "/session", { email: user.email, password: "lolwut" }, default_headers

      expect(response).to be_success
      json = JSON.parse(response.body)
      expect(json["user"]["name"]).to eq "Mr Test"
      expect(json["user"]["api_token"]).to eq user.api_token
    end

    it "returns all the user's organizations" do
      post "/session", { email: user.email, password: "lolwut" }, default_headers

      expect(response).to be_success
      json = JSON.parse(response.body)
      expect(json["user"]["organizations"][0]["name"]).to eq "ÖeG"
      expect(json["user"]["organizations"][1]["name"]).to eq "Excons"
    end

    it "fails when using incorrect email and password" do
      post "/session", { email: user.email, password: "omgwat" }, default_headers
      expect(response).not_to be_success
    end
  end
end
