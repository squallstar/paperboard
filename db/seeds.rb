# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# encoding: utf-8

puts 'Clearing entities...'

User.delete_all
Project.delete_all
ProjectMember.delete_all
ProjectInvite.delete_all
Organization.delete_all
Team.delete_all
TeamMember.delete_all
Plan.delete_all
Subscription.delete_all

puts "\r\nStarting up the seed..."

User.create!(
  [
    {
      first_name: 'Nicholas',
      last_name: 'Valbusa',
      email: 'test@test.com',
      password: 'cojone',
      password_confirmation: 'cojone'
    },
    {
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      email: 'test2@test.com',
      password: 'cojone',
      password_confirmation: 'cojone'
    }
  ]
)

first_user = User.first
second_user = User.offset(1).first

1.upto(3) do |o|
  puts "Generating organization #{o}."
  organization = Organization.new_with_user({ name: Faker::Company.name }, first_user)
  organization.save!
end

first_organization = Organization.first

puts 'Creating new teams'
pm_team = first_organization.teams.create(name: 'Project managers', role: 'admin')
pm_team.members.create role: 'admin', user: second_user
team = first_organization.teams.create(name: 'Developers', role: 'standard')
team.members.create role: 'standard', user: second_user

1.upto(2) do |p|
  puts "\r\nGenerating project #{p}."

  project = Project.create!(
    name: Faker::Company.catch_phrase,
    owner: first_user
  )

  ProjectMember.create!(
    user: first_user,
    project: project,
    role: 'owner'
  )

  user = nil

  1.upto(5) do |i|
    user = User.create!(
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      email: Faker::Internet.email,
      password: 'testtest',
      password_confirmation: 'testtest'
    )

    puts "User #{user.full_name} created."

    ProjectMember.create!(
      user: user,
      project: project,
      role: 'member'
    )

    TeamMember.create!(
      user: user,
      team: team,
      role: 'member'
    )
  end

  TeamMember.create!(
    user: user,
    team: pm_team,
    role: 'member'
  )

  1.upto(3) do |i|
    puts "Generating invite #{i} for project #{p}"
    ProjectInvite.create!(
      email: Faker::Internet.email,
      project: project,
      accepted: true,
      key: '1234',
      sender: first_user
    )
  end

end

ProjectInvite.create!(
  email: 'squallstar@gmail.com',
  project: Project.first,
  accepted: true,
  key: '1234',
  sender: User.first,
  user: User.first(offset: 1)
)

puts "\r\nImporting plans from Paymill..."
Rake::Task['paymill:import_plans'].invoke

puts 'Done!'
