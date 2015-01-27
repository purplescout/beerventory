require "rails_helper"

describe Beer do
  context "validations" do
    describe "#barcode" do
      it "is required" do
        beer = Beer.make(barcode: nil)
        expect(beer).not_to be_valid
        expect(beer.errors[:barcode]).to eq ["can't be blank"]
      end

      it "must be unique" do
        Beer.make!(barcode: "123")
        beer = Beer.make(barcode: "123")
        expect(beer).not_to be_valid
        expect(beer.errors[:barcode]).to eq ["has already been taken"]
      end
    end

    describe "#name" do
      it "is required" do
        beer = Beer.make(name: "")
        expect(beer).not_to be_valid
        expect(beer.errors[:name]).to eq ["can't be blank"]
      end
    end
  end
end
