class ProductDescription
  def initialize(product)
    @product = product
  end

  def brand_name
    @product.brand.try(:name)
  end

  def piece_count
    @product.piece_count > 1 ? "#{@product.piece_count}x" : nil
  end

  def units
    return nil if @product.units.nil?
    unit = @product.units.to_unit
    return nil if unit == Unit.new('1 piece')
    unit
  end

  def piece_name
    method = @product.piece_count == 1 ? :singularize : :pluralize
    @product.piece_name.try(method)
  end

  def description
    [brand_name, @product.name, piece_count, units, piece_name].join(' ')
  end
end
