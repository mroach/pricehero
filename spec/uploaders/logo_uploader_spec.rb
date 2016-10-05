require 'rails_helper'

RSpec.describe LogoUploader, type: :uploader do
  let(:brand) { double('brand', id: 1, to_s: 'Elle & Virre') }
  let(:uploader) { described_class.new(brand, :logo) }
  let(:sample_file) { File.join(Dir.pwd, 'spec/support/sample_files/1200x1200.png') }

  before do
    described_class.enable_processing = true
    File.open(sample_file) { |f| uploader.store!(f) }
  end

  after do
    described_class.enable_processing = false
    uploader.remove!
  end

  context 'the thumb version' do
    it 'scales down a landscape image to be exactly 50 by 50 pixels' do
      expect(uploader.thumb).to have_dimensions(50, 50)
    end
  end

  context 'the small version' do
    it 'scales down a landscape image to fit within 100 by 100 pixels' do
      expect(uploader.small).to be_no_larger_than(100, 100)
    end
  end

  context 'the medium version' do
    it 'scales down a landscape image to fit within 200 by 200 pixels' do
      expect(uploader.medium).to be_no_larger_than(200, 200)
    end
  end

  describe '#filename' do
    it 'is a parameterized version of the brand name' do
      expect(uploader.filename).to eq 'elle-virre.png'
    end
  end
end
