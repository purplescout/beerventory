require "rails_helper"

describe "Users API" do
  let(:default_headers) do { "Accept" => "application/json" } end
  let(:user) { User.make! }
  let(:auth_headers) do { "X-Beerventory-Token" => user.api_token } end

  before do
    user.organizations << Organization.make!(name: "ÖeG")
    user.organizations << Organization.make!(name: "Excons")
  end

  describe "fetching info about logged in user" do
    it "returns all the user's organizations" do
      get "/users/me", nil, default_headers.merge(auth_headers)

      expect(response).to be_success
      json = JSON.parse(response.body)
      expect(json["user"]["organizations"][0]["name"]).to eq "ÖeG"
      expect(json["user"]["organizations"][1]["name"]).to eq "Excons"
    end
  end
end
