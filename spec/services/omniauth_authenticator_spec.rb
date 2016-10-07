require 'rails_helper'

RSpec.describe OmniauthAuthenticator do
  subject { described_class.new(create(:oauth)) }

  context 'with a new user' do
    describe '#new_identity?' do
      its(:new_identity?) { is_expected.to be true }
    end

    describe '#user' do
      its(:user) { is_expected.not_to be_persisted }
      its(:user) { is_expected.to be_reporter }

      its('user.nickname') { is_expected.not_to be_blank }
      its('user.password') { is_expected.not_to be_blank }
      its('user.name') { is_expected.not_to be_blank }
    end

    describe '#persist_user!' do
      it 'creates a new user record' do
        expect { subject.persist_user! }.to change(User, :count).by(1)
      end

      it 'has the identity record' do
        subject.persist_user!
        expect(User.last.identities).to be_present
      end
    end
  end
end
