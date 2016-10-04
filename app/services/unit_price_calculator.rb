# Calculates the unit price for a product. A product will have units of some
# kind, such as a 500 mL beer, 150g of instant coffee, or 25 pieces
# The product will have a price, and this will convert to a standard unit
# for price comparison. For example $10 for 250 mL of beer has a unit price
# of $40 per litre
class UnitPriceCalculator
  def initialize(item_price, item_units, bulk_units)
    @item_price = item_price
    @item_units = item_units.to_unit
    @bulk_units = bulk_units.to_unit
  end

  # Ensure the item and bulk units are the same
  # For example if it's 200g of coffee and the bult unit is 1kg, we want
  # to see it as 0.2kg
  def converted_units
    @item_units.convert_to(@bulk_units)
  end

  # Figure out how this product compares to our bulk units
  # For example if we have 0.2kg of coffee and our bulk unit is 1kg, we have 0.2
  def fractional_units
    (converted_units / @bulk_units).scalar
  end

  # Figure out the unit price returning a Money object
  # For example a product price of $10 for 200g and a bulk unit of 1kg,
  # the unit price is $50.
  # When you divide a money object by a number it returns a new Money object
  def unit_price
    @item_price / fractional_units
  end

  # Label to use for the unit price "denominator"
  # If the bulk units have a scalar value of 1, such as 1 kg, 1 piece, just use
  # the unit label itself
  # Otherwise, use the whole unit. Such as if you're doing "per 100 pieces" or
  # per 100g
  def unit_label
    @bulk_units.scalar == 1 ? @bulk_units.units : @bulk_units.to_s
  end

  def to_s
    "#{unit_price.format} / #{unit_label}"
  end
end
