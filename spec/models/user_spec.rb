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

    describe "#api_token" do
      it "is set to a random string by default" do
        user = User.make!
        expect(user.api_token).to be_present
      end

      it "is changed when the user changes password" do
        user = User.make!(password: "test", password_confirmation: "test")
        old_token = user.api_token

        user.update_attributes(password: "abc", password_confirmation: "abc")
        expect(user.api_token).not_to eq old_token
      end
    end
  end
end
