# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# encoding: utf-8

User.delete_all
Project.delete_all
ProjectMember.delete_all

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

Project.create!({
  name: 'Test project'
})

ProjectMember.create!({
  user: User.first,
  project: Project.first,
  role: 'owner'
})

ProjectInvite.create!({
  email: 'squallstar@gmail.com',
  project: Project.first,
  accepted: true,
  key: '1234',
  sender: User.first,
  user: User.first
})