require "rails_helper"

describe "Organizations API" do
  let(:default_headers) do { "Accept" => "application/json" } end
  let(:auth_headers) do { "X-Beerventory-Token" => user.api_token } end
  let(:user) { User.make! }
  let!(:organization) { Organization.make! }

  describe "fetching latest status" do
    it "fails when not logged in" do
      get "/organizations/#{organization.id}", nil, default_headers

      expect(response.status).to eq 401
    end

    it "fetches status values for organization" do
      History.make!(user: user, organization: organization, beer: Beer.make, in: 2, out: 3)
      History.make!(user: user, organization: organization, beer: Beer.make, in: 20, out: 0)
      Inventory.make!(organization: organization, beer: Beer.make!, amount: 10)
      Inventory.make!(organization: organization, beer: Beer.make!, amount: 10)
      Membership.make!(organization: organization, user: User.make)
      Membership.make!(organization: organization, user: User.make)

      get "/organizations/#{organization.id}", nil, default_headers.merge(auth_headers)

      expect(response).to be_success
      json = JSON.parse(response.body)
      expect(json["organization"]["no_users"]).to eq 2
      expect(json["organization"]["fridge_amount"]).to eq 20
      expect(json["organization"]["user_amount"]).to eq 19
    end
  end
end
