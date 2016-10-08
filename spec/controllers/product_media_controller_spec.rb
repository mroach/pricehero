require 'rails_helper'

RSpec.describe ProductMediaController, type: :controller do
  let(:valid_attributes) {
    attrs = attributes_for :product_medium
    attrs[:product_id] = create(:product).id
    attrs
  }

  let(:invalid_attributes) {
    { product_id: nil }
  }

  let(:new_attributes) {
    { title: Faker::Hipster.sentence }
  }

  before(:each) do
    sign_in create(:user, :superuser)
  end

  it_behaves_like 'a resource controller'
end
