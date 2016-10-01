require 'rails_helper'

RSpec.describe PricesQuery do
  describe '#best_price' do
    it 'finds the best price (report)' do
      product = create(:product)
      create(:report, product: product, price: 100)
      best_price = create(:report, product: product, price: 90)

      expect(described_class.new(product).best_price).to eq best_price
    end
  end

  describe '#store_prices' do
    it 'finds the latest prices per store' do
      product = create(:product)
      store1 = create(:store)
      store2 = create(:store)

      report1 = create(:report, product: product, store: store1, reported_at: 1.day.ago)
      report2 = create(:report, product: product, store: store2, reported_at: 1.hour.ago)
      outdated_report = create(:report, product: product, store: store1, reported_at: 2.days.ago)

      reports = described_class.new(product).store_prices

      expect(reports.length).to eq 2
      expect(reports).not_to include outdated_report
      expect(reports).to include report1
      expect(reports).to include report2
    end
  end
end
