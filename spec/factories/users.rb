FactoryGirl.define do
  factory :user do
    name { Faker::Name.name }
    sequence(:email) { |n| Faker::Internet.safe_email("#{name}_#{n}") }
    nickname { Faker::Internet.user_name }
  end
end
