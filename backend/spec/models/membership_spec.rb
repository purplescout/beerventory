require "rails_helper"

describe Membership do
  context "validations" do
    describe "#user" do
      it "is required" do
        membership = Membership.make(user: nil)
        expect(membership).not_to be_valid
        expect(membership.errors[:user]).to eq ["can't be blank"]
      end
    end

    describe "#organization" do
      it "is required" do
        membership = Membership.make(organization: nil)
        expect(membership).not_to be_valid
        expect(membership.errors[:organization]).to eq ["can't be blank"]
      end

      it "must be unique for every user" do
        user = User.make
        organization = Organization.make
        Membership.make!(user: user, organization: organization)
        membership = Membership.make(user: user, organization: organization)
        expect(membership).not_to be_valid
        expect(membership.errors[:organization]).to eq ["has already been taken"]
      end
    end
  end
end
