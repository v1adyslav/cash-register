RSpec.describe CalculatePercentDiscount, type: :service do
  describe '#call' do
    let(:discount_type) { 'percent' }

    let(:product) do
      Product.new('CF1', 'Coffee', 11.23, 'euro',
                  { 'type' => discount_type, 'min_count' => 3, 'percent' => 0.3333 })
    end

    it 'no discount' do
      count = 2
      discount = described_class.call(product, count)
      expect(discount).to eq(0)
    end

    it 'has discount' do
      count = 3
      discount = described_class.call(product, count)
      expect(discount).to eq(3 * 0.3333 * 11.23)
    end

    it 'has discount' do
      count = 4
      discount = described_class.call(product, count)
      expect(discount).to eq(4 * 0.3333 * 11.23)
    end
  end
end
