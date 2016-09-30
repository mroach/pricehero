class ChangeReportDefaultCurrency < ActiveRecord::Migration[5.0]
  def change
    change_column_default :reports, :price_currency, 'THB'
  end
end
