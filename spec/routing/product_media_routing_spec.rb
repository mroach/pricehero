require 'rails_helper'

RSpec.describe ProductMediaController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/product_media').to route_to('product_media#index')
    end

    it 'routes to #new' do
      expect(get: '/product_media/new').to route_to('product_media#new')
    end

    it 'routes to #show' do
      expect(get: '/product_media/1').to route_to('product_media#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/product_media/1/edit').to route_to('product_media#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/product_media').to route_to('product_media#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/product_media/1').to route_to('product_media#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/product_media/1').to route_to('product_media#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/product_media/1').to route_to('product_media#destroy', id: '1')
    end
  end
end
