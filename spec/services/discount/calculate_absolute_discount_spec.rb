RSpec.describe CalculateAbsoluteDiscount, type: :service do
  describe '#call' do
    let(:discount_type) { Discount::ABSOLUTE }

    let(:product) { Product.new('SR1', 'Strawberries', 5.0, 'euro', discount_type) }
    let(:discount) { Discount.new({ 'type' => discount_type, 'count' => 3, 'value' => 0.5 }) }

    it 'no discount' do
      count = 2
      value = described_class.call(product, count, discount)
      expect(value).to eq(0)
    end

    it 'has discount' do
      count = 3
      value = described_class.call(product, count, discount)
      expect(value).to eq(1.5)
    end

    it 'has discount' do
      count = 4
      value = described_class.call(product, count, discount)
      expect(value).to eq(2.0)
    end
  end
end
