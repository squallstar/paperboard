# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# encoding: utf-8

puts "Clearing entities..."

User.delete_all
Project.delete_all
ProjectMember.delete_all
ProjectInvite.delete_all
Organization.delete_all
OrganizationMember.delete_all
Plan.delete_all
Subscription.delete_all

puts "\r\nStarting up the seed..."

User.create!(
  [
    {
      password: 'testtest',
      password_confirmation: 'testtest',
      email: 'test@test.com',
      first_name: 'Nicholas',
      last_name: 'Valbusa'
    },
    {
      password: 'testtest',
      password_confirmation: 'testtest',
      email: 'test2@test.com',
      first_name: 'Michela',
      last_name: 'Tannoia'
    }
  ]
)

first_user = User.first

1.upto(3) do |o|
  puts "Generating organization #{o}."
  organization = Organization.create(:name => Faker::Company.name)

  OrganizationMember.create({
    user: first_user,
    organization: organization,
    role: 'owner'
  })
end

first_organization = Organization.first

1.upto(8) do |p|
  puts "\r\nGenerating project #{p}."

  project = Project.create(
    name: Faker::Company.catch_phrase
  )

  ProjectMember.create({
    user: first_user,
    project: project,
    role: 'owner'
  })

  1.upto(14) do |i|
    user = User.create(
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      email: "#{p}#{i}" + Faker::Internet.email,
      password: 'testtest',
      password_confirmation: 'testtest'
    )

    puts "User #{user.full_name} created."

    ProjectMember.create!({
      user: user,
      project: project,
      role: 'member'
    })

    OrganizationMember.create({
      user: user,
      organization: first_organization,
      role: 'member'
    })
  end

  1.upto(5) do |i|
    puts "Generating invite #{i} for project #{p}"
    ProjectInvite.create!({
      email: Faker::Internet.email,
      project: project,
      accepted: true,
      key: '1234',
      sender: first_user,
    })
  end

end

ProjectInvite.create!({
  email: 'squallstar@gmail.com',
  project: Project.first,
  accepted: true,
  key: '1234',
  sender: User.first,
  user: User.first(:offset => 1)
})

puts "\r\nImporting plans from Paymill..."
Rake::Task['paymill:import_plans'].invoke

puts "Done!"