RubyUnits::Unit.define('piece') do |unit|
  unit.scalar       = 1
  unit.numerator    = %w(<piece>)
  unit.aliases      = %w(pc piece pieces)
  unit.kind         = :counting
end
