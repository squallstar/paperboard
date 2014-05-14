# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :team_invite do
    accepted ''
    email 'MyString'
    sender nil
    team nil
  end
end
