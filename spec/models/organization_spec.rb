require 'spec_helper'

describe Organization do
  it "should belong to the free plan" do
    organization = create(:organization)

    expect(organization.plan).to eq "free"
    expect(organization.plan("projects")).to be > 0
    expect(organization.plan("teams")).to be > 0
    expect(organization.plan("users")).to be > 1
  end

  it "should belong to a given user when created and have a default owners team" do
    user = create(:user)
    organization = Organization.new_with_user({name: Faker::Company.name}, user)
    organization.save!

    expect(organization.users.count).to eq 1
    expect(organization.users.first).to eq user

    expect(organization.teams.count).to eq 1
    expect(organization.teams.where(role: 'admin').count).to eq 1
    expect(organization.teams.first.members.count).to eq 1
    expect(organization.teams.first.members.first.user).to eq user
  end
end