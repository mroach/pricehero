require 'rails_helper'

RSpec.describe Brand, type: :model do
  describe 'Concerns' do
    it_behaves_like 'a paranoid model'
    it_behaves_like 'a friendly id model'
    it { is_expected.to be_versioned }
    it { is_expected.to have_uploader :logo, LogoUploader }
  end

  describe 'Associations' do
    it { is_expected.to have_many :products }
  end

  describe 'Validations' do
    subject { build(described_class.model_name.singular) }
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_uniqueness_of(:name).case_insensitive }
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

  describe '#initials' do
    subject { described_class.new(name: name).initials }
    context 'one word' do
      let(:name) { 'Derp' }
      it { is_expected.to eq 'D' }
    end

    context 'two words' do
      let(:name) { 'Aslan Mega' }
      it { is_expected.to eq 'AM' }
    end

    context 'two words and a symbol' do
      let(:name) { 'Bashir & Kira' }
      it { is_expected.to eq 'B&K' }
    end

    context 'lowercase name' do
      let(:name) { 'praveline' }
      it { is_expected.to eq 'P' }
    end
  end

  describe '#to_s' do
    subject { build(described_class.model_name.singular) }
    its(:to_s) { is_expected.to eq subject.name }
  end
end
