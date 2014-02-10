FactoryGirl.define do
  factory :user do

    email { Faker::Internet.email }
    password { "mydummypassword" }
    password_confirmation {|u| u.password }

    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }

    trait :with_projects do
      after(:build) do |u|
        Random.rand(1..10).times do
          u.projects << build(:project)
        end
      end
    end
  end
end