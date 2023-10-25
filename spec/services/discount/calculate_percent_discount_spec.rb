RSpec.describe CalculatePercentDiscount, type: :service do
  describe '#call' do
    let(:discount_type) { Discount::PERCENT }

    let(:product) { Product.new('CF1', 'Coffee', 11.23, 'euro', discount_type) }
    let(:discount) { Discount.new({ 'type' => discount_type, 'count' => 3, 'value' => 0.3333 }) }

    it 'no discount' do
      count = 2
      value = described_class.call(product, count, discount)
      expect(value).to eq(0)
    end

    it 'has discount' do
      count = 3
      value = described_class.call(product, count, discount)
      expect(value).to eq(3 * 0.3333 * 11.23)
    end

    it 'has discount' do
      count = 4
      value = described_class.call(product, count, discount)
      expect(value).to eq(4 * 0.3333 * 11.23)
    end
  end
end
