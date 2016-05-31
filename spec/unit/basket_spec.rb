require 'basket'

describe Basket do

  subject(:basket){ described_class.new }
  let(:item1){ double 'Item', price: 9.25 }
  let(:item2){ double 'Item', price: 45.00 }

  it 'registers a single item' do
    basket.add(item1)
    expect(basket.first).to eq item1
  end

  it 'registers more than one item' do
    basket.add(item1)
    basket.add(item2)
    expect(basket.count).to eq 2
  end

  it 'calculates the base cost of all contained items' do
    basket.add(item1)
    basket.add(item2)
    expect(basket.total).to eq 54.25
  end
end
