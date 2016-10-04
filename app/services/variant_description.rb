# Generates the full description for a Variant. The name will vary depending on
# properties of it, such as piece count, units, piece name, etc
# See the related spec file for example usage and output
class VariantDescription
  def initialize(variant)
    @variant = variant
  end

  def brand_name
    @variant.brand.try(:name)
  end

  def piece_count
    @variant.piece_count > 1 ? "#{@variant.piece_count}x" : nil
  end

  def units
    return nil if @variant.units.nil?
    unit = @variant.units.to_unit
    return nil if unit == Unit.new('1 piece')
    unit
  end

  def piece_name
    method = @variant.piece_count == 1 ? :singularize : :pluralize
    @variant.piece_name.try(method)
  end

  def description
    [brand_name, @variant.name, piece_count, units, piece_name].join(' ')
  end
end
