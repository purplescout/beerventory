require "rails_helper"

describe "Inventory API" do
  let(:default_headers) do { "Accept" => "application/json" } end
  let(:auth_headers) do { "X-Beerventory-Token" => user.api_token } end
  let(:user) { User.make! }
  let(:organization) { Organization.make! }
  let(:beer1) { Beer.make!(barcode: "1234", name: "Pripps Blå") }
  let(:beer2) { Beer.make!(barcode: "2345", name: "Mythos") }

  before do
    Inventory.make!(organization: organization, beer: beer1, amount: 10)
    Inventory.make!(organization: organization, beer: beer2, amount: 0)
  end

  describe "listing inventory" do
    it "fails when not logged in" do
      get "/organizations/#{organization.id}/inventory", nil, default_headers

      expect(response.status).to eq 401
    end

    it "fetches beer inventory for this organization" do
      get "/organizations/#{organization.id}/inventory", nil, default_headers.merge(auth_headers)

      expect(response).to be_success
      json = JSON.parse(response.body)
      expect(json["inventories"].length).to eq 1

      expect(json["inventories"][0]["beer"]["name"]).to eq "Pripps Blå"
      expect(json["inventories"][0]["amount"]).to eq 10
    end
  end

  describe "updating inventory" do
    it "changes the amount for the beers in the request" do
      put "/organizations/#{organization.id}/inventory",
        { beers: [{ id: beer1.id, amount: 3 }, { id: beer2.id, amount: -4 }] },
        default_headers.merge(auth_headers)

      expect(response).to be_success
      expect(Inventory.where(organization_id: organization.id, beer_id: beer1.id).first.amount).to eq 13
      expect(Inventory.where(organization_id: organization.id, beer_id: beer2.id).first.amount).to eq -4
    end

    it "adds new beers to an organization's inventory if needed" do
      beer3 = Beer.make!
      put "/organizations/#{organization.id}/inventory",
        { beers: [{ id: beer3.id, amount: 2 }] },
        default_headers.merge(auth_headers)

      expect(response).to be_success
      expect(Inventory.where(organization_id: organization.id, beer_id: beer3.id).first.amount).to eq 2
    end

    it "fails for malformed requests" do
      put "/organizations/#{organization.id}/inventory",
        { beers: beer1.id },
        default_headers.merge(auth_headers)

      expect(response).not_to be_success

      put "/organizations/#{organization.id}/inventory",
        { beer: beer1.id },
        default_headers.merge(auth_headers)

      expect(response).not_to be_success
    end

    it "fails if not logged in" do
      put "/organizations/#{organization.id}/inventory",
        { beers: [{ id: beer1.id, amount: 3 }] },
        default_headers

      expect(response).not_to be_success
    end

    it "creates user history if it succeeds" do
      put "/organizations/#{organization.id}/inventory",
        { beers: [{ id: beer1.id, amount: 3 }, { id: beer2.id, amount: -4 }] },
        default_headers.merge(auth_headers)

      expect(response).to be_success
      expect(History.where(user_id: user.id, organization_id: organization.id, beer_id: beer1.id).first.in).to eq 3
      expect(History.where(user_id: user.id, organization_id: organization.id, beer_id: beer2.id).first.out).to eq 4
    end

    it "does not create user history if it does not succeed" do
      put "/organizations/#{organization.id}/inventory",
        { beers: [{ id: beer1.id, amount: 3 }, { id: beer2.id, amount: -4 }] },
        default_headers

      expect(response).not_to be_success
      expect(History.where(user_id: user.id, organization_id: organization.id, beer_id: beer1.id).first).to be_nil
      expect(History.where(user_id: user.id, organization_id: organization.id, beer_id: beer2.id).first).to be_nil
    end
  end
end
