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

  it "should not accept two users with the same email address" do
    first = User.create(first_name: "A", last_name: "B", email: "foo@bar.com", password: "123456", password_confirmation: "123456")
    second = User.create(first_name: "C", last_name: "D", email: first.email, password: "123456", password_confirmation: "123456")
    expect(User.count).to eq 1
  end

  it "should keep updated a user full_name" do
    user = User.create(first_name: "A", last_name: "B", email: "foo@bar.com", password: "123456", password_confirmation: "123456")
    expect(user.full_name).to eq "A B"
  end
end
