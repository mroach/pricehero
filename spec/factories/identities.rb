FactoryGirl.define do
  factory :identity do
    user
    provider 'facebook'
    uid { Faker::Internet.password(32) }
  end
end
