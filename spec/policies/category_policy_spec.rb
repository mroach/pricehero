require 'rails_helper'

RSpec.describe CategoryPolicy do
  let(:record) { create(:category) }
  let(:resolved_scope) { described_class::Scope.new(user, Category.all).resolve }
  subject { described_class.new(user, record) }

  it_behaves_like 'readonly for', nil
  it_behaves_like 'readonly for', :viewer
  it_behaves_like 'full read/write for', :admin
  it_behaves_like 'full read/write for', :superuser
end
