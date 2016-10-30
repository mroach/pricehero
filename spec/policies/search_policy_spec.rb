require 'rails_helper'

RSpec.describe SearchPolicy do
  subject { described_class.new(user, nil) }

  context 'no user' do
    let(:user) { User.new }
    it { is_expected.to permit_action :multi }
  end

  context 'with a logged-in user' do
    let(:user) { User.new }
    it { is_expected.not_to permit_action :multi }
  end
end
