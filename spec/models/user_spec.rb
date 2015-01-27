require "rails_helper"

describe User do
  context "validations" do
    describe "#email" do
      it "is required" do
        user = User.make(email: "")
        expect(user).not_to be_valid
        expect(user.errors[:email]).to eq ["can't be blank"]
      end

      it "must be unique" do
        User.make!(email: "taken@example.com")
        user = User.make(email: "taken@example.com")
        expect(user).not_to be_valid
        expect(user.errors[:email]).to eq ["has already been taken"]
      end
    end

    describe "#password" do
      it "must be more than 3 characters long" do
        user = User.make(password: "pw")
        expect(user).not_to be_valid
        expect(user.errors[:password]).to eq ["is too short (minimum is 3 characters)"]
      end
    end

    describe "#password_confirmation" do
      it "is required" do
        user = User.make(password: "", password_confirmation: "")
        expect(user).not_to be_valid
        expect(user.errors[:password_confirmation]).to eq ["can't be blank"]
      end

      it "must match the password" do
        user = User.make(password: "password123", password_confirmation: "password789")
        expect(user).not_to be_valid
        expect(user.errors[:password_confirmation]).to eq ["doesn't match Password"]
      end
    end
  end
end
