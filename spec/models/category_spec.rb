require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:factory_name) { described_class.model_name.singular }

  describe 'Concerns' do
    it_behaves_like 'a friendly id model'
    it { is_expected.to be_versioned }
    it { is_expected.to be_a_closure_tree }
  end

  describe 'Associations' do
    it { is_expected.to have_many :products }
  end

  describe 'Validations' do
    subject { build(factory_name) }
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_uniqueness_of(:name).case_insensitive }

    describe 'valid_units' do
      context 'acceptable units' do
        subject { build(factory_name, bulk_units: '100g') }
        it { is_expected.to be_valid }
      end

      context 'blank units' do
        subject { build(factory_name, bulk_units: nil) }
        it { is_expected.to be_valid }
      end

      context 'number without units' do
        subject { build(factory_name, bulk_units: '10') }
        it { is_expected.not_to be_valid }
        it 'has units in the errors' do
          subject.valid?
          expect(subject.errors).to have_key :bulk_units
          expect(subject.errors[:bulk_units]).to include 'missing unit of measure'
        end
      end
    end
  end

  describe '#path' do
    let(:parent) { create(:category) }
    let(:child) { create(:category, parent: parent) }
    subject { child.path }

    context 'default separator' do
      it { is_expected.to be_a String }
      it { is_expected.to start_with parent.name }
      it { is_expected.to end_with child.name }
    end
  end

  describe '#to_s' do
    let(:category) { build(:category) }
    subject { category.to_s }
    it { is_expected.to be_a String }
    it { is_expected.to include category.name }
  end

  describe '#should_generate_new_friendly_id?' do
    {
      name: -> { Faker::Commerce.product_name }
    }.each do |k, v|
      context "changing trigger field '#{k}'" do
        subject { create(described_class.model_name.singular) }
        it 'updates the slug' do
          value = v.is_a?(Proc) ? v.call : v
          subject.send("#{k}=", value)
          expect { subject.save }.to change(subject, :slug)
        end
      end
    end
  end
end
