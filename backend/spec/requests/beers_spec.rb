require "rails_helper"

describe "Beers API" do
  let(:default_headers) do { "Accept" => "application/json" } end
  let(:auth_headers) do { "X-Beerventory-Token" => user.api_token } end
  let(:user) { User.make! }

  before do
    beer = Beer.make!(barcode: "1234", name: "Pripps Blå")
  end

  describe "fetching beers" do
    it "fails when not logged in" do
      get "/beers/1234", nil, default_headers

      expect(response.status).to eq 401
    end

    it "fetches beer name based on barcode" do
      get "/beers/1234", nil, default_headers.merge(auth_headers)

      expect(response).to be_success
      json = JSON.parse(response.body)
      expect(json["beer"]["name"]).to eq "Pripps Blå"
    end
  end

  describe "saving beers" do
    it "saves beer for a new barcode" do
      post "/beers", { beer: { barcode: "141414", name: "Singha", volume: "0.66" } }, default_headers.merge(auth_headers)

      expect(response).to be_success
      json = JSON.parse(response.body)
      expect(json["beer"]["name"]).to eq "Singha"
      expect(json["beer"]["volume"]).to eq "0.66"
    end

    it "fails if not logged in" do
      post "/beers", { beer: { barcode: "141414", name: "Singha", volume: "0.66" } }, default_headers
      expect(response).not_to be_success
    end

    it "fails if trying to create a new beer with existing barcode" do
      Beer.make!(barcode: "141414")
      post "/beers", { beer: { barcode: "141414", name: "Singha", volume: "0.66" } }, default_headers
      expect(response).not_to be_success
    end
  end
end
