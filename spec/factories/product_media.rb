FactoryGirl.define do
  factory :product_medium do
    product
    file { File.open(File.join(Dir.pwd, 'spec/support/sample_files/coffee.jpg')) }
    title { Faker::Hipster.sentence }
    content_type { %w(image/jpeg image/gif image/png).sample }
  end
end
