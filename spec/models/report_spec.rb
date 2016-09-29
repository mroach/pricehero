require 'rails_helper'

RSpec.describe Report, type: :model do
  describe 'Concerns' do
    it_behaves_like 'a paranoid model'
    it { is_expected.to be_versioned }
  end

  describe 'Associations' do
    it { is_expected.to belong_to :store }
    it { is_expected.to belong_to :product }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of :store }
    it { is_expected.to validate_presence_of :product }
    it { is_expected.to validate_presence_of :reported_at }
    it { is_expected.to validate_numericality_of(:price).is_greater_than(0) }
  end

  describe 'Attributes' do
    it { is_expected.to monetize :price }
  end
end
