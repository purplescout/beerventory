require "rails_helper"

describe Organization do
  context "validations" do
    describe "#name" do
      it "is required" do
        organization = Organization.make(name: "")
        expect(organization).not_to be_valid
        expect(organization.errors[:name]).to eq ["can't be blank"]
      end
    end

    describe "#code" do
      it "is required" do
        organization = Organization.make(code: "")
        expect(organization).not_to be_valid
        expect(organization.errors[:code]).to eq ["can't be blank"]
      end

      it "must be unique" do
        Organization.make!(code: "abc")
        organization = Organization.make(code: "abc")
        expect(organization).not_to be_valid
        expect(organization.errors[:code]).to eq ["has already been taken"]
      end
    end
  end
end
