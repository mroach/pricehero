FactoryGirl.define do
  factory :report do
    variant
    store
    reported_at { 1.day.ago }
    price { Money.new(1 + Faker::Commerce.price, 'THB') }
  end
end
