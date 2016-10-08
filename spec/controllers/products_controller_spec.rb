require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  let(:valid_attributes) {
    attrs = attributes_for :product
    attrs[:brand_id] = create(:brand).id
    attrs[:category_id] = create(:category).id
    attrs
  }

  let(:invalid_attributes) {
    { name: nil }
  }

  let(:new_attributes) {
    { name: Faker::Company.name }
  }

  before(:each) do
    sign_in create(:user, :superuser)
  end

  it_behaves_like 'a resource controller'
end
