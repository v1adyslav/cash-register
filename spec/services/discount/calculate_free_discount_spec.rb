RSpec.describe CalculateFreeDiscount, type: :service do
  describe '#call' do
    let(:discount_type) { 'free' }

    context 'with free=1 parameter' do
      let(:product) do
        Product.new('GR1', 'Green Tea', 3.11, 'euro',
                    { 'type' => discount_type, 'count' => 1, 'free' => 1 })
      end

      it 'no discount' do
        count = 1
        discount = described_class.call(product, count)
        expect(discount).to eq(0)
      end

      it 'has discount' do
        count = 2
        discount = described_class.call(product, count)
        expect(discount).to eq(3.11)
      end

      it 'has discount' do
        count = 3
        discount = described_class.call(product, count)
        expect(discount).to eq(3.11)
      end

      it 'incorrect data, no discount' do
        count = -1
        discount = described_class.call(product, count)
        expect(discount).to eq(0)
      end

      it 'no discount' do
        count = 0
        discount = described_class.call(product, count)
        expect(discount).to eq(0)
      end
    end

    context 'with free=2 parameter' do
      let(:product) do
        Product.new('GR1', 'Green Tea', 3.11, 'euro',
                    { 'type' => discount_type, 'count' => 1, 'free' => 2 })
      end

      it 'no discount' do
        count = 1
        discount = described_class.call(product, count)
        expect(discount).to eq(0)
      end

      it 'has discount' do
        count = 2
        discount = described_class.call(product, count)
        expect(discount).to eq(6.22)
      end

      it 'has discount' do
        count = 3
        discount = described_class.call(product, count)
        expect(discount).to eq(6.22)
      end
    end
  end
end
