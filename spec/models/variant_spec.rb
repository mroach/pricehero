require 'rails_helper'

RSpec.describe Variant, type: :model do
  describe 'Concerns' do
    it_behaves_like 'a paranoid model'
    it_behaves_like 'a friendly id model'
    it { is_expected.to be_versioned }
  end

  describe 'Associations' do
    it { is_expected.to belong_to :product }
    it { is_expected.to have_many(:reports).dependent(:destroy) }
  end

  describe 'Delegations' do
    it { is_expected.to delegate_method(:brand).to(:product) }
    it { is_expected.to delegate_method(:category).to(:product) }
    it { is_expected.to delegate_method(:name).to(:product) }
  end

  describe 'Validations' do
    subject { build(described_class.model_name.singular) }
    it { is_expected.to validate_numericality_of(:piece_count).is_greater_than(0) }

    describe 'valid_gtin' do
      context 'blank gtin' do
        subject { build(:variant, gtin: nil) }
        it { is_expected.to be_valid }
      end

      context 'valid gtin' do
        subject { build(:variant, gtin: '9300650658417') }
        it { is_expected.to be_valid }
      end

      context 'invalid gtin' do
        subject { build(:variant, gtin: '9300650658418') }
        it { is_expected.not_to be_valid }
        it 'has gtin in the errors' do
          subject.valid?
          expect(subject.errors).to have_key :gtin
        end
      end
    end
  end
end
