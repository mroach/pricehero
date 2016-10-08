require 'rails_helper'

RSpec.describe VariantsController, type: :controller do
  let(:valid_attributes) {
    attrs = attributes_for :variant
    attrs[:product_id] = create(:product).id
    attrs
  }

  let(:invalid_attributes) {
    { piece_name: nil }
  }

  let(:new_attributes) {
    { piece_name: 'derp' }
  }

  before(:each) do
    sign_in create(:user, :superuser)
  end

  it_behaves_like 'a resource controller'
end
