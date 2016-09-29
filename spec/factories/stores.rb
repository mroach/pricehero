FactoryGirl.define do
  factory :store do
    name { Faker::Company.name }
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }
  end
end
