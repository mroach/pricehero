[
  ['Allowrie', 'Salted Butter', 'Butter', '454g', 165, "Pod's", nil],
  ['Allowrie', 'Unsalted butter', 'Butter', '227g', 105, "Pod's", nil],
  ['Allowrie', 'Unsalted butter', 'Butter', '454g', 165, "Pod's", nil],
  ['Colgate', 'Cavity Protect', 'Toothpaste', '170g', 50, 'Aukotan', 'US'],
  ['Drogheria & Alimentari', 'Black Pepper Mill', 'Pepper', '45g', 110, 'Chaiwat', 'IT'],
  ['Drogheria & Alimentari', 'Sea Salt Mill', 'Salt', '90g', 110, 'Chaiwat', 'IT'],
  ['Elle & Vire', 'Salted Butter', 'Butter', '200g', 165, "Pod's", nil],
  ['Elle & Vire', 'Unsalted butter', 'Butter', '500g', 245, "Pod's", 'FR'],
  ['Elle & Vire', 'Unsalted butter', 'Butter', '200g', 165, "Pod's", nil],
  ['Familia', 'Berry Crunch', 'Müsli/Granola', '500g', 195, 'Pen Wholesale', nil],
  ['Ferrero', 'Nutella', 'Spread', '200g', 120, 'Umpah 2', 'IT'],
  ['Ferrero', 'Nutella', 'Spread', '680g', 300, 'Umpah 2', 'IT'],
  ['Foremost', 'Unflavoured UHT Milk', 'Milk', '1 l', 50, 'Smile Mart', 'TH'],
  ["Hershey's", 'Chocolate Spread', 'Spread', '368g', 190, 'Umpah 2', 'US'],
  ['Jif', 'Creamy Peanut Butter', 'Peanut butter', '454g', 170, 'Umpah 2', 'US'],
  ['Jif', 'Extra Crunchy Peanut Butter', 'Peanut butter', '454g', 170, 'Umpah 2', 'US'],
  ['Jif', 'Extra Crunchy Peanut Butter', 'Peanut butter', '454g', 185, 'Pen Wholesale', nil],
  ['Kraft', 'Vegemite', 'Spread', '220g', 170, "Pod's", 'AU'],
  ['Lipton', 'English Breakfast', 'Black Tea', '25 pieces', 175, 'Chaiwat', 'UK'],
  ['McCormick', 'Black Pepper Mill', 'Pepper', '70g', nil, nil, nil],
  ['McCormick', 'Sea Salt Mill', 'Salt', '172g', nil, nil, nil],
  ['Meiji', 'Whole Milk', 'Milk', '830 mL', 50, '7/11 Sairee Main Road', 'JP'],
  ['Moccona', 'Royal Gold', 'Instant Coffee', '100g', 235, 'Smile Mart', 'NL'],
  ['Mutti', 'Polpa (Chopped Tomatoes)', 'Tinned Tomatoes', '400g', 85, "Pod's", nil],
  ['Nestlé', 'Nescafe Gold', 'Instant Coffee', '200g', 320, 'Aukotan', 'CH'],
  ["Reese's", 'Peanut Butter Chocolate Spread', 'Spread', '368g', 190, 'Umpah 2', 'US'],
  ['Skippy', 'Creamy Peanut Butter', 'Peanut butter', '510g', 200, "Pod's", nil],
  ['Skippy', 'Superchunk', 'Peanut butter', '510g', 190, 'Smile Mart', 'US'],
  ['Skippy', 'Superchunk', 'Peanut butter', '510g', 200, "Pod's", nil],
  ["Smucker's", 'Blueberry Jam', 'Jam', '340g', 120, 'Pen Wholesale', nil],
  ["Smucker's", 'Blueberry Preserves', 'Fruit Preserves', '340g', 130, "Pod's", 'US'],
  ["Smucker's", 'Concord Grape Jam', 'Jam', '340g', 145, 'Pen Wholesale', nil],
  ["Smucker's", 'Red Raspberry Preserves', 'Fruit Preserves', '340g', 130, "Pod's", 'US'],
  ["Smucker's", 'Red Raspberry Preserves', 'Fruit Preserves', '340g', 120, 'Pen Wholesale', nil],
  ["Smucker's", 'Strawberry Preserves', 'Fruit Preserves', '340g', 130, "Pod's", 'US'],
  ["Smucker's", 'Sweet Orange Marmalade', 'Fruit Preserves', '340g', 130, "Pod's", 'US'],
  ['Svedka', 'Vodka', 'Vodka', '750 mL', 400, 'Smile Mart', 'SE'],
  ["Twining's", 'Darjeeling Tea', 'Black Tea', '25 pieces', 205, 'Chaiwat', 'UK'],
  ["Twining's", 'Earl Grey', 'Black Tea', '25 pieces', 240, "Pod's", nil],
  ["Twining's", 'English Breakfast', 'Black Tea', '25 pieces', 205, 'Chaiwat', 'UK'],
  ["Twining's", 'English Breakfast', 'Black Tea', '25 pieces', 240, "Pod's", 'UK'],
  ['Vaseline', 'Body Wash for Men', 'Body wash', '450 mL', 150, 'Aukotan', 'US'],
  ['Vaseline', 'Body Wash for Men (Refill)', 'Body wash', '200 mL', 65, 'Pen Wholesale', nil],
  ['Vaseline', 'Intensive Care Aloe Soothe', 'Body lotion', '400 mL', 185, 'Aukotan', 'US']
].each do |p|
  brand = Brand.find_or_create_by! name: p[0]
  category = Category.find_or_create_by! name: p[2]
  product = Product.find_or_create_by(name: p[1], brand: brand, category: category, units: p[3])
  next unless p[5].present? && p[4].present?
  store = Store.find_or_create_by! name: p[5]
  report_time = Time.new.utc(2016, 9, 29, 12, 0, 0)
  Report.find_or_create_by!(product: product, store: store, reported_at: report_time) do |r|
    r.price = Money.new(p[4] * 100, 'THB')
  end
end
