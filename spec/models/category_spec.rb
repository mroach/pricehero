require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'Concerns' do
    it_behaves_like 'a friendly id model'
    it { is_expected.to be_versioned }
  end

  describe 'Associations' do
    it { is_expected.to have_many :products }
  end

  describe 'Validations' do
    subject { build(described_class.model_name.singular) }
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_uniqueness_of(:name).case_insensitive }
  end

  describe '#to_s' do
    let(:category) { build(:category) }
    subject { category.to_s }
    it { is_expected.to be_a String }
    it { is_expected.to include category.name }
  end
end
