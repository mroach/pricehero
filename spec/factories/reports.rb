FactoryGirl.define do
  factory :report do
    product
    store
    reported_at { 1.day.ago }
    price { Money.new(Faker::Commerce.price, 'THB') }
  end
end
