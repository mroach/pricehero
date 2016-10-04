require 'rails_helper'

RSpec.describe VariantDescription do
  let(:brand) { double(Brand, name: 'Acme') }

  describe 'brand_name' do
    context 'product with brand' do
      let(:product) { double(Product, brand: brand) }
      subject { described_class.new(product).brand_name }
      it { is_expected.to eq brand.name }
    end

    context 'product without brand' do
      let(:product) { double(Product, brand: nil) }
      subject { described_class.new(product).brand_name }
      it { is_expected.to be_nil }
    end
  end

  # ex) 24 pack of beer
  describe 'piece_count' do
    context 'single piece item' do
      let(:product) { double(Product, piece_count: 1) }
      subject { described_class.new(product).piece_count }
      it { is_expected.to be_nil }
    end

    context 'multi-piece item' do
      let(:product) { double(Product, piece_count: 24) }
      subject { described_class.new(product).piece_count }
      it { is_expected.to eq '24x' }
    end
  end

  describe 'units' do
    context 'item with no units' do
      let(:product) { double(Product, units: nil) }
      subject { described_class.new(product).units }
      it { is_expected.to be_nil }
    end

    context 'item with a unit of one piece' do
      let(:product) { double(Product, units: '1 piece') }
      subject { described_class.new(product).units }
      it { is_expected.to be_nil }
    end

    context 'item with units other than 1 piece' do
      let(:product) { double(Product, units: '400 mL') }
      subject { described_class.new(product).units }
      # For some reason, using 'is_expected.to be_a Unit' fails
      it 'is a Unit' do
        expect(subject.class).to eq Unit
      end
    end
  end

  describe 'piece_name' do
    context 'with nil piece name' do
      let(:product) { double(Product, piece_count: 1, piece_name: nil) }
      subject { described_class.new(product).piece_name }
      it { is_expected.to be_nil }
    end

    context 'item with pieces > 1 and a piece name' do
      let(:product) { double(Product, piece_count: 24, piece_name: 'cans') }
      subject { described_class.new(product).piece_name }
      it { is_expected.to eq 'cans' }
    end

    context 'item with pieces = 1 and a piece name' do
      let(:product) { double(Product, piece_count: 1, piece_name: 'cans') }
      subject { described_class.new(product).piece_name }
      it { is_expected.to eq 'can' }
    end
  end

  describe 'description' do
    context 'multi-piece product with quantities' do
      let(:product) {
        double(Product,
               brand:       brand,
               name:        'Lager',
               piece_count: 24,
               piece_name:  'cans',
               units:       '330 mL')
      }
      subject { described_class.new(product).description }

      it { is_expected.to eq 'Acme Lager 24x 330 ml cans' }
    end
  end
end
