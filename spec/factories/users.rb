FactoryGirl.define do
  factory :user do
    name { Faker::Name.name }
    sequence(:email) { |n| Faker::Internet.safe_email("#{name}_#{n}") }
    nickname { Faker::Internet.user_name }

    trait :reporter do
      role :reporter
    end

    trait :editor do
      role :editor
    end

    trait :admin do
      role :admin
    end

    trait :superuser do
      role :superuser
    end
  end
end
