require 'rails_helper'

RSpec.describe 'Search', type: :request do
  before(:each) do
    sign_in create(:user, :superuser)
  end

  describe 'GET /search?q=:query' do
    it 'find our product' do
      products = create_list(:product, 2)
      name_part = products.first.name.split(/\s+/).first.downcase
      get search_path, params: { q: name_part }

      expect(response).to have_http_status(:success)
      expect(response.body).to include %(Search results for "#{name_part}")
      expect(response.body).to include products.first.name
    end
  end
end
