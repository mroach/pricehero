require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Concerns' do
    it_behaves_like 'a paranoid model'
    it_behaves_like 'a friendly id model'
    it { is_expected.to be_versioned }
    it { is_expected.to have_uploader :images, ProductImageUploader }
  end

  describe 'Associations' do
    it { is_expected.to belong_to :brand }
    it { is_expected.to belong_to :category }
    it { is_expected.to have_many(:variants).dependent(:destroy) }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of :brand }
    it { is_expected.to validate_presence_of :name }
  end

  describe '#should_generate_new_friendly_id?' do
    context 'changing a trigger field' do
      subject { create(:product) }
      it 'updates the slug' do
        subject.name = Faker::Commerce.product_name
        expect { subject.save }.to change(subject, :slug)
      end
    end
  end

  describe '#to_s' do
    let(:product) { build(described_class.model_name.singular) }
    subject { product.to_s }
    it { is_expected.to be_a String }
    it { is_expected.to include product.name }
    it { is_expected.to include product.brand.name }
  end
end
