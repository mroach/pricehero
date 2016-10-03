FactoryGirl.define do
  factory :variant do
    product
    units { Unit.new("#{Faker::Number.number(3)} g") }
  end
end
