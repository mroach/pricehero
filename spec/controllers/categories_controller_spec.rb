require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  let(:valid_attributes) { attributes_for :category }

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
