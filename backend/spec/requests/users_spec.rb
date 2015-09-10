require "rails_helper"

describe "Users API" do
  let(:default_headers) do { "Accept" => "application/json" } end
  let(:user) { User.make! }
  let(:auth_headers) do { "X-Beerventory-Token" => user.api_token } end
  let(:organization) { Organization.make!(name: "ÖeG") }

  before do
    user.organizations << organization
    user.organizations << Organization.make!(name: "Excons")
  end

  describe "signing up" do
    before do
      Organization.make!(name: "ÖeG", code: "abc")
    end

    it "creates a user and joins a specified organization" do
      post "/users", { user: { email: "test@example.com", password: "password", password_confirmation: "password", name: "Mr Test" }, invitation_code: "abc" }, default_headers

      expect(response).to be_success
      json = JSON.parse(response.body)
      expect(json["user"]["email"]).to eq "test@example.com"
      expect(json["user"]["name"]).to eq "Mr Test"
      expect(json["user"]["organizations"][0]["name"]).to eq "ÖeG"
    end

    it "fails if there is a problem with the user" do
      post "/users", { user: { email: "", password: "password", password_confirmation: "password", name: "Mr Test" }, invitation_code: "abc" }, default_headers

      expect(response).not_to be_success
      json = JSON.parse(response.body)
      expect(json["errors"]["email"]).to eq ["can't be blank"]
    end

    it "does not create the user if the org code is invalid" do
      expect {
        post "/users", { user: { email: "test@example.com", password: "password", password_confirmation: "password", name: "Mr Test" }, invitation_code: "pxpxp" }, default_headers
      }.to change { User.count }.by(0)

      expect(response).not_to be_success
      json = JSON.parse(response.body)
      expect(json["errors"]["organization"]).to eq ["can't be blank"]
    end
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

  describe "fetching a list of members of an organization" do
    let(:user2) { User.make! }

    before do
      user2.organizations << organization
    end

    it "returns the users without their organizations in the serialization" do
      get "/organizations/#{organization.id}/users", nil, default_headers.merge(auth_headers)

      expect(response).to be_success
      json = JSON.parse(response.body)
      expect(json["users"][0]["id"]).to eq user.id
      expect(json["users"][1]["id"]).to eq user2.id
      expect(json["users"][0]["organizations"]).to be_nil
    end

    it "returns the user's total beer amount for the organization" do
      History.make!(user: user, organization: organization, beer: Beer.make!, in: 3, out: 10)

      get "/organizations/#{organization.id}/users", nil, default_headers.merge(auth_headers)

      expect(response).to be_success
      json = JSON.parse(response.body)
      expect(json["users"][0]["id"]).to eq user.id
      expect(json["users"][0]["beer_amount"]).to eq -7
    end

    it "fails if not logged in" do
      get "/organizations/#{organization.id}/users", nil, default_headers
      expect(response).not_to be_success
    end
  end
end
