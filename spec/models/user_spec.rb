require 'spec_helper'

describe User do
  it "should not accept incomplete users" do
    User.create(first_name: "A")
    User.create(first_name: "A", last_name: "C")
    User.create(email: "foo@bar.com")
    User.create(first_name: "A", last_name: "C", email: "foo@bar.com")
    User.create(first_name: "A", last_name: "C", email: "foo@bar.com", password: "123456")
    expect(User.count).to eq 0
  end

  it "should not accept s user with an invalid email" do
    user = User.create(first_name: "A", last_name: "B", email: "foo", password: "123456", password_confirmation: "123456")
    expect(user.errors.count).to eq 1
    expect(User.count).to eq 0
  end

  it "should not accept two users with the same email address" do
    first = User.create(first_name: "A", last_name: "B", email: "foo@bar.com", password: "123456", password_confirmation: "123456")
    second = User.create(first_name: "C", last_name: "D", email: first.email, password: "123456", password_confirmation: "123456")
    expect(User.count).to eq 1
  end

  it "should keep updated a user full_name" do
    (0..10).each do
      user = create(:user)
      expect(user.full_name).to eq "#{user.first_name} #{user.last_name}"
    end
  end

  it "should belong to the free plan" do
    user = create(:user)

    expect(user.plan).to eq "free"
    expect(user.plan("projects")).to be > 0
    expect(user.plan("teams")).to be > 0
    expect(user.plan("users")).to be > 1
  end
end