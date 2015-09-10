require "rails_helper"

describe "History API" do
  let(:default_headers) do { "Accept" => "application/json" } end
  let(:auth_headers) do { "X-Beerventory-Token" => user.api_token } end
  let(:user) { User.make! }
  let(:organization) { Organization.make! }

  before do
    beer1 = Beer.make!(barcode: "1234", name: "Pripps Blå")
    beer2 = Beer.make!(barcode: "2345", name: "Mythos")

    History.make!(user: user, organization: organization, beer: beer1, in: 2, out: 3)
    History.make!(user: user, organization: organization, beer: beer2, in: 20, out: 0)
    History.make!(organization: organization, beer: beer1, in: 2, out: 3)
    History.make!(user: user, beer: beer1, in: 2, out: 3)
  end

  it "fails when not logged in" do
    get "/organizations/#{organization.id}/history", nil, default_headers

    expect(response.status).to eq 401
  end

  it "fetches user's beer history for this organization" do
    get "/organizations/#{organization.id}/history", nil, default_headers.merge(auth_headers)

    expect(response).to be_success
    json = JSON.parse(response.body)
    expect(json["histories"].length).to eq 2

    expect(json["histories"][0]["beer"]["name"]).to eq "Pripps Blå"
    expect(json["histories"][0]["in"]).to eq 2
    expect(json["histories"][0]["out"]).to eq 3

    expect(json["histories"][1]["beer"]["name"]).to eq "Mythos"
    expect(json["histories"][1]["in"]).to eq 20
    expect(json["histories"][1]["out"]).to eq 0
  end
end
