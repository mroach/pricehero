FactoryGirl.define do
  factory :product do
    brand
    category
    name { Faker::Commerce.product_name }
  end
end
