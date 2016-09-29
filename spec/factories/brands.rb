FactoryGirl.define do
  factory :brand do
    name { Faker::Company.name }
    country { Faker::Address.country_code }
  end
end
