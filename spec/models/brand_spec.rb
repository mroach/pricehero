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

  describe 'Uploaders' do
    it 'has #logo uploader' do
      expect(described_class.uploaders).to have_key :logo
    end

    it 'has LogoUploader at :logo' do
      expect(described_class.uploaders[:logo]).to eq LogoUploader
    end
  end

  describe '#should_generate_new_friendly_id?' do
    context 'changing a trigger field' do
      subject { create(:brand) }
      it 'updates the slug' do
        subject.name = Faker::Commerce.department
        expect { subject.save }.to change(subject, :slug)
      end
    end
  end

  describe '#to_s' do
    subject { build(described_class.model_name.singular) }
    its(:to_s) { is_expected.to eq subject.name }
  end
end
