require "rails_helper"

describe "Inventory API" do
  let(:default_headers) do { "Accept" => "application/json" } end
  let(:auth_headers) do { "X-Beerventory-Token" => user.api_token } end
  let(:user) { User.make! }
  let(:organization) { Organization.make! }

  before do
    beer1 = Beer.make!(barcode: "1234", name: "Pripps Blå")
    beer2 = Beer.make!(barcode: "2345", name: "Mythos")

    Inventory.make!(organization: organization, beer: beer1, amount: 10)
    Inventory.make!(organization: organization, beer: beer2, amount: 0)
  end

  it "fails when not logged in" do
    get "/organizations/#{organization.id}/inventory", nil, default_headers

    expect(response.status).to eq 401
  end

  it "fetches beer inventory for this organization" do
    get "/organizations/#{organization.id}/inventory", nil, default_headers.merge(auth_headers)

    expect(response).to be_success
    json = JSON.parse(response.body)
    expect(json["inventories"].length).to eq 2

    expect(json["inventories"][0]["beer"]["name"]).to eq "Pripps Blå"
    expect(json["inventories"][0]["amount"]).to eq 10

    expect(json["inventories"][1]["beer"]["name"]).to eq "Mythos"
    expect(json["inventories"][1]["amount"]).to eq 0
  end
end
