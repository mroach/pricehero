require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Concerns' do
    it_behaves_like 'a paranoid model'
    it_behaves_like 'a friendly id model'
    it { is_expected.to be_versioned }
  end

  describe 'Associations' do
    it { is_expected.to belong_to :brand }
    it { is_expected.to belong_to :category }
    it { is_expected.to have_many(:reports).dependent(:destroy) }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of :brand }
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_numericality_of(:piece_count).is_greater_than(0) }

    describe 'valid_gtin' do
      context 'blank gtin' do
        subject { build(:product, gtin: nil) }
        it { is_expected.to be_valid }
      end

      context 'valid gtin' do
        subject { build(:product, gtin: '9300650658417') }
        it { is_expected.to be_valid }
      end

      context 'invalid gtin' do
        subject { build(:product, gtin: '9300650658418') }
        it { is_expected.not_to be_valid }
        it 'has gtin in the errors' do
          subject.valid?
          expect(subject.errors).to have_key :gtin
        end
      end
    end
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
