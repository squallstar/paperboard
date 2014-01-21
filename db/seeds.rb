# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# encoding: utf-8

Faker::Config.locale = 'it'

User.delete_all
Project.delete_all
ProjectMember.delete_all

puts "Starting up the seed..."

User.create!(
  [
    {
      username: 'squallstar',
      password: 'test',
      password_confirmation: 'test',
      email: 'test@test.com',
      first_name: 'Nicholas',
      last_name: 'Valbusa'
    },
    {
      username: 'mintsugar',
      password: 'test',
      password_confirmation: 'test',
      email: 'test2@test.com',
      first_name: 'Michela',
      last_name: 'Tannoia'
    }
  ]
)

first_user = User.first

1.upto(8) do |p|
  puts "Generating project #{p}."

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
      username: "user#{p}#{i}",
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      email: "#{p}#{i}" + Faker::Internet.email,
      password: 'test',
      password_confirmation: 'test'
    )

    puts "User #{user.full_name} created."

    ProjectMember.create!({
      user: user,
      project: project,
      role: 'member'
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

puts "Done!"