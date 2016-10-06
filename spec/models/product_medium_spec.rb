require 'rails_helper'

RSpec.describe ProductMedium, type: :model do
  describe 'Concerns' do
    it_behaves_like 'a paranoid model'
    it { is_expected.to be_versioned }
    it { is_expected.to have_uploader :file, ProductImageUploader }
  end

  describe 'Associations' do
    it { is_expected.to belong_to(:product).touch(true) }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of :product }
    it { is_expected.to validate_presence_of :file }
  end

  describe 'changing the file' do
    subject { described_class.new }
    let(:file) {
      File.join(Dir.pwd, 'spec/support/sample_files/coffee.jpg')
    }
    before do
      subject.product = build(:product)
      subject.file = File.open(file)
      subject.save
    end

    its(:content_type) { is_expected.to eq 'image/jpeg' }
    its(:size) { is_expected.to be > 0 }
    its(:size) { is_expected.to eq File.stat(file).size }
  end
end
