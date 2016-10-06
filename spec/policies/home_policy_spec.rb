require 'rails_helper'

RSpec.describe HomePolicy do
  subject { described_class.new(user, :home) }

  context 'anonymous' do
    let(:user) { nil }
    it { is_expected.to permit_action :show }
  end
end
