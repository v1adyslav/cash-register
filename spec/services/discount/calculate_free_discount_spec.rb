RSpec.describe CalculateFreeDiscount, type: :service do
  describe '#call' do
    let(:discount_type) { Discount::FREE }

    context 'with free=1 parameter' do
      let(:product) { Product.new('GR1', 'Green Tea', 3.11, 'euro', discount_type) }
      let(:discount) { Discount.new({ 'type' => discount_type, 'count' => 1, 'value' => 1 }) }

      it 'no discount' do
        count = 1
        value = described_class.call(product, count, discount)
        expect(value).to eq(0)
      end

      it 'has discount' do
        count = 2
        value = described_class.call(product, count, discount)
        expect(value).to eq(3.11)
      end

      it 'has discount' do
        count = 3
        value = described_class.call(product, count, discount)
        expect(value).to eq(3.11)
      end

      it 'incorrect data, no discount' do
        count = -1
        value = described_class.call(product, count, discount)
        expect(value).to eq(0)
      end

      it 'no discount' do
        count = 0
        value = described_class.call(product, count, discount)
        expect(value).to eq(0)
      end
    end

    context 'with free=2 parameter' do
      let(:product) { Product.new('GR1', 'Green Tea', 3.11, 'euro', discount_type) }
      let(:discount) { Discount.new({ 'type' => discount_type, 'count' => 1, 'value' => 2 }) }

      it 'no discount' do
        count = 1
        value = described_class.call(product, count, discount)
        expect(value).to eq(0)
      end

      it 'has discount' do
        count = 2
        value = described_class.call(product, count, discount)
        expect(value).to eq(6.22)
      end

      it 'has discount' do
        count = 3
        value = described_class.call(product, count, discount)
        expect(value).to eq(6.22)
      end
    end
  end
end
