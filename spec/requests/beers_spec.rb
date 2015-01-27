require "rails_helper"

describe "Beers API" do
  let(:default_headers) do { "Accept" => "application/json" } end
  let(:auth_headers) do { "X-Beerventory-Token" => user.api_token } end
  let(:user) { User.make! }

  before do
    beer = Beer.make!(barcode: "1234", name: "Pripps Blå")
  end

  it "fails when not logged in" do
    get "/beers/1234", nil, default_headers

    expect(response.status).to eq 401
  end

  it "fetches beer name based on barcode" do
    get "/beers/1234", nil, default_headers.merge(auth_headers)

    expect(response).to be_success
    json = JSON.parse(response.body)
    expect(json["name"]).to eq "Pripps Blå"
  end
end
