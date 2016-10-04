require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Concerns' do
    it_behaves_like 'a paranoid model'
    it_behaves_like 'a friendly id model'
    it { is_expected.to be_versioned }
  end

  describe 'Associations' do
    it { is_expected.to have_many :reports }
    it { is_expected.to have_many(:identities).dependent(:destroy) }
  end

  describe 'Validations' do
    subject { build(described_class.model_name.singular) }
    it { is_expected.to validate_presence_of :email }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :nickname }
  end

  describe 'Attributes' do
    it { is_expected.to define_enum_for :role }
  end

  describe '#email=' do
    context 'when sending mixed case value' do
      it 'downcases email' do
        user = build(:user, email: 'USER1@example.org')
        expect(user.email).to eq 'user1@example.org'
      end
    end
    context 'when sending value with extraneous whitespace' do
      it 'strips' do
        user = build(:user, email: 'user1@example.org ')
        expect(user.email).to eq 'user1@example.org'
      end
    end
    context 'when sending nil' do
      it 'saves nil' do
        user = build(:user)
        user.email = nil
        expect(user.email).to be_nil
      end
    end
  end
end
