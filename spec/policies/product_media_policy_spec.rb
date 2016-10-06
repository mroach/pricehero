require 'rails_helper'

RSpec.describe ProductMediumPolicy do
  let(:record) { create(:product_medium) }
  let(:resolved_scope) { described_class::Scope.new(user, ProductMedium.all).resolve }
  subject { described_class.new(user, record) }

  it_behaves_like 'readonly for', nil
  it_behaves_like 'readonly for', :viewer
  it_behaves_like 'full read/write for', :admin
  it_behaves_like 'full read/write for', :superuser
end
