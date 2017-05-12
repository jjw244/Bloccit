require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.create!(name: "Bloccit User", email: "user@bloccit.com", password: "password") }

  it { is_expected.to have_many(:posts) }

# Shoulda tests for name
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_length_of(:name).is_at_least(1) }

# Shoulda tests for email
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_uniqueness_of(:email) }
  it { is_expected.to validate_length_of(:email).is_at_least(3) }
  it { is_expected.to allow_value("user@bloccit.com").for(:email) }

 # Shoulda tests for password
  it { is_expected.to validate_presence_of(:password) }
  it { is_expected.to have_secure_password }
  it { is_expected.to validate_length_of(:password).is_at_least(6) }

  describe "attributes" do
    it "should have name and email attributes" do
      expect(user).to have_attributes(name: "Bloccit User", email: "user@bloccit.com")
    end
  end

# #1  wrote a test that does not follow the same conventions as our previous tests.
 #We are testing for a value that we know should be invalid (true negative).
  describe "invalid user" do
    let(:user_with_invalid_name) { User.new(name: "", email: "user@bloccit.com") }
    let(:user_with_invalid_email) { User.new(name: "Bloccit User", email: "") }

    it "should be an invalid user due to blank name" do
      expect(user_with_invalid_name).to_not be_valid
    end

    it "should be an invalid user due to blank email" do
      expect(user_with_invalid_email).to_not be_valid
    end
  end

# #1  expect that users will respond to role
    it "responds to role" do
      expect(user).to respond_to(:role)
    end

# #2  expect users will respond to admin?, which will return whether or not a user is an admin. We'll implement this using the ActiveRecord::Enum class
    it "responds to admin?" do
      expect(user).to respond_to(:admin?)
    end

# #3  expect users will respond to member?, which will return whether or not a user is a member
    it "responds to member?" do
      expect(user).to respond_to(:member?)
    end

  describe "roles" do
# #4  expect that users will be assigned the role of member by default
    it "is member by default" do
      expect(user.role).to eql("member")
    end

# #5  test member and admin users within separate contexts
    context "member user" do
      it "returns true for #member?" do
        expect(user.member?).to be_truthy
      end

      it "returns false for #admin?" do
        expect(user.admin?).to be_falsey
      end
    end

# #6  test member and admin users within separate contexts
    context "admin user" do
      before do
        user.admin!
      end

      it "returns false for #member?" do
        expect(user.member?).to be_falsey
      end

      it "returns true for #admin?" do
        expect(user.admin?).to be_truthy
      end
    end
  end
end
