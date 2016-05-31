require 'checkout'

describe Checkout do

  let(:basket) { instance_spy "Basket"  }
  let(:item_rules) { [lambda {|x|  }] }
  let(:global_rules) { [lambda {|x|  }] }
  let(:promotional_rules) { { item_rules: item_rules, global_rules: global_rules } }
  subject(:co) { described_class.new(promotional_rules, basket) }

  let(:co_no_promotion) { described_class.new( {}, basket) }
  let(:item) { double "Item" }

  describe '#scan' do
    it 'adds an item to the basket' do
      co.scan(item)
      expect(basket).to have_received(:add).with(item)
    end
  end

  describe '#total' do
    before :each do
      allow(basket).to receive(:total).and_return(100)
    end

    it 'returns the basket total when there are no promotional rules' do
      expect(co_no_promotion.total).to eq 100
    end

    context 'calls to lambdas and other objects' do
      it 'applies item promotional rules' do
        expect(promotional_rules[:item_rules].first).to receive(:call)
        co.total
      end

      it 'applies global promotional rules' do
        expect(promotional_rules[:global_rules].first).to receive(:call)
        co.total
      end

      it 'requests a total from the basket' do
        expect(basket).to receive(:total)
        co.total
      end
    end
  end
end
