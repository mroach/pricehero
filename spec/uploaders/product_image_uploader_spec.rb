require 'rails_helper'

RSpec.describe ProductImageUploader, type: :uploader do
  let(:product) { double('product', id: 1, to_s: 'Elle & Virre', token: '1234') }
  let(:uploader) { described_class.new(product, :images) }
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
    it 'scales down a landscape image to be exactly 100 by 100 pixels' do
      expect(uploader.thumb).to have_dimensions(100, 100)
    end
  end

  context 'the small version' do
    it 'scales down a landscape image to fit within 200 by 200 pixels' do
      expect(uploader.small).to be_no_larger_than(200, 200)
    end
  end

  context 'the medium version' do
    it 'scales down a landscape image to fit within 600 by 600 pixels' do
      expect(uploader.medium).to be_no_larger_than(600, 600)
    end
  end

  context 'the large version' do
    it 'scales down a landscape image to fit within 800 by 800 pixels' do
      expect(uploader.large).to be_no_larger_than(800, 800)
    end
  end

  context 'filename' do
    it 'used the token and original extension' do
      expect(uploader.filename).to eq('1234.png')
    end
  end
end
