require 'rails_helper'

RSpec.describe Report, type: :model do
  describe 'Concerns' do
    it_behaves_like 'a paranoid model'
    it { is_expected.to be_versioned }
  end

  describe 'Associations' do
    it { is_expected.to belong_to :store }
    it { is_expected.to belong_to :variant }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of :store }
    it { is_expected.to validate_presence_of :variant }
    it { is_expected.to validate_presence_of :reported_at }
    it { is_expected.to validate_numericality_of(:price).is_greater_than(0) }
  end

  describe 'Attributes' do
    it { is_expected.to monetize :price }
  end

  describe 'Callbacks' do
    describe 'after_initialize' do
      context 'setting-up a new model' do
        subject { described_class.new }
        its(:reported_at) { is_expected.not_to be_nil }
      end

      context 'loading an stored values' do
        # Ensures defaults initializer doesn't run when the model is persisted
        it 'uses the persisted value' do
          reported_at = 1.day.ago
          create(:report, reported_at: reported_at)
          expect(Report.last.reported_at).to eq reported_at
        end
      end
    end
  end
end
