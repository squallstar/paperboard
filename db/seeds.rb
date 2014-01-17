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
      username: 'test',
      password: 'test',
      password_confirmation: 'test',
      email: 'test@test.com',
      first_name: 'John',
      last_name: 'Doe'
    },
    {
      username: 'test2',
      password: 'test',
      password_confirmation: 'test',
      email: 'test2@test.com',
      first_name: 'John',
      last_name: 'Second Doe'
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

Invite.create!({
  email: 'squallstar@gmail.com',
  project: Project.first,
  accepted: false,
  key: '1234',
  sender: User.first
})

Invite.create!({
  email: 'squallstar+accepted@gmail.com',
  project: Project.first,
  accepted: true,
  key: '12345',
  sender: User.first,
  user: User.limit(2)[1]
})