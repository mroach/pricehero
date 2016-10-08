require 'rails_helper'

RSpec.describe ReportPolicy do
  let(:record) { create(:report) }
  let(:resolved_scope) { described_class::Scope.new(user, Report.all).resolve }
  subject { described_class.new(user, record) }

  it_behaves_like 'readonly for', nil
  it_behaves_like 'readonly for', :viewer
  it_behaves_like 'full read/write for', :admin
  it_behaves_like 'full read/write for', :superuser

  context 'a reporter' do
    let(:user) { build(:user, :reporter) }
    it { is_expected.to permit_action :new }
    it { is_expected.to permit_action :create }
  end

  context 'an editor' do
    let(:user) { build(:user, :editor) }
    it { is_expected.to permit_action :new }
    it { is_expected.to permit_action :create }
  end
end
