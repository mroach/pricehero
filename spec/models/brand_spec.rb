require 'rails_helper'

RSpec.describe Brand, type: :model do
  describe 'Concerns' do
    it_behaves_like 'a paranoid model'
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
end
