require 'rails_helper'

RSpec.describe Store, type: :model do
  describe 'Concerns' do
    it_behaves_like 'a paranoid model'
    it_behaves_like 'a friendly id model'
    it { is_expected.to be_versioned }
  end

  describe 'Associations' do
    it { is_expected.to have_many :reports }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of :name }
  end

  describe '#to_s' do
    let(:store) { build(described_class.model_name.singular) }
    subject { store.to_s }
    it { is_expected.to be_a String }
    it { is_expected.to include store.name }
  end
end
