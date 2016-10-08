require 'rails_helper'

RSpec.describe ReportsController, type: :controller do
  let(:valid_attributes) {
    attrs = attributes_for :report
    attrs[:variant_id] = create(:variant).id
    attrs[:store_id] = create(:store).id
    attrs
  }

  let(:invalid_attributes) {
    { price: nil }
  }

  let(:new_attributes) {
    { variant_id: create(:variant).id }
  }

  context 'normal resource operations' do
    before(:each) do
      sign_in create(:user, :admin)
    end

    it_behaves_like 'a resource controller'
  end

  describe 'POST #create' do
    let(:user) { create(:user, :reporter) }
    before(:each) do
      sign_in user
    end

    it 'sets the user on the report' do
      post :create, params: { report: valid_attributes }
      expect(Report.last.user).to eq user
    end
  end
end
