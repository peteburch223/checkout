require 'checkout'

describe 'calculating expected price', feature: true do

  ITEM001_UNIT_DISCOUNT = 0.75
  ITEM001_QTY_FOR_DISCOUNT = 2
  GLOBAL_DISCOUNT_THRESHOLD = 60
  GLOBAL_DISCOUNT_RATE = 0.1

  Item = Struct.new(:product_code, :name, :price)
  let(:item1) { Item.new('001', 'Lavender heart', 9.25) }
  let(:item2) { Item.new('002', 'Personalised cufflinks', 45.00) }
  let(:item3) { Item.new('002', 'Kids T-shirt', 19.95) }

  let(:global_rule1) {
    lambda do |total|
      total * GLOBAL_DISCOUNT_RATE if total > GLOBAL_DISCOUNT_THRESHOLD
    end
  }

  let(:item_rule1) {
    lambda do |basket|
      item_count = basket.count { |item| item.product_code == item1.product_code }
      item_count * ITEM001_UNIT_DISCOUNT if item_count >= ITEM001_QTY_FOR_DISCOUNT
    end
  }

  let(:promotional_rules) { { item_rules: [item_rule1],
                              global_rules: [global_rule1] } }

  it 'calculates the total for basket 1' do
    co = Checkout.new(promotional_rules)
    co.scan(item1)
    co.scan(item2)
    co.scan(item3)
    expect(co.total).to eq 66.78
  end

  it 'calculates the total for basket 2' do
    co = Checkout.new(promotional_rules)
    co.scan(item1)
    co.scan(item3)
    co.scan(item1)
    expect(co.total).to eq 36.95
  end

  it 'calculates the total for basket 3' do
    co = Checkout.new(promotional_rules)
    co.scan(item1)
    co.scan(item2)
    co.scan(item1)
    co.scan(item3)
    expect(co.total).to eq 73.76
  end

  it 'calculates the raw price total if there are no promotional rules' do
    co = Checkout.new
    co.scan(item1)
    co.scan(item1)
    co.scan(item2)
    co.scan(item2)
    expect(co.total).to eq 108.50
  end
end
