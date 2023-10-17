RSpec.describe CalculateAbsoluteDiscount, type: :service do
  describe '#call' do
    let(:discount_type) { 'absolute' }

    let(:product) do
      Product.new('SR1', 'Strawberries', 5.0, 'euro',
                  { 'type' => discount_type, 'min_count' => 3, 'absolute' => 0.5 })
    end

    it 'no discount' do
      count = 2
      discount = described_class.call(product, count)
      expect(discount).to eq(0)
    end

    it 'has discount' do
      count = 3
      discount = described_class.call(product, count)
      expect(discount).to eq(1.5)
    end

    it 'has discount' do
      count = 4
      discount = described_class.call(product, count)
      expect(discount).to eq(2.0)
    end
  end
end
