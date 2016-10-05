require 'rails_helper'

RSpec.describe Identity, type: :model do
  describe 'Concerns' do
    it_behaves_like 'a paranoid model'
    it { is_expected.to be_versioned }
  end

  describe 'Associations' do
    it { is_expected.to belong_to :user }
  end

  describe 'Validations' do
    subject { build(:identity) }
    it { is_expected.to validate_presence_of :uid }
    it { is_expected.to validate_presence_of :provider }
    it { is_expected.to validate_uniqueness_of(:provider).scoped_to(:user_id) }
    it { is_expected.to validate_uniqueness_of(:uid).scoped_to(:provider).case_insensitive }
  end

  describe '.find_by_oauth' do
    context 'with a new unknown identity' do
      let(:oauth) { build(:oauth) }
      let(:identity) { Identity.find_by_oauth(oauth) }

      describe 'is created' do
        subject { identity }
        it { is_expected.to be_an Identity }
        it { is_expected.not_to be_persisted }
      end

      describe '#provider' do
        subject { identity.provider }
        it { is_expected.not_to be_blank }
        it { is_expected.to eq oauth.provider.to_s }
      end

      describe '#uid' do
        subject { identity.uid }
        it { is_expected.not_to be_blank }
        it { is_expected.to eq oauth.uid }
      end

      describe '#info' do
        subject { identity.info }
        it { is_expected.not_to be_blank }
        it { is_expected.to eq oauth.info }
      end
    end
  end
end
