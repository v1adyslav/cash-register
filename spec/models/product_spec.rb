RSpec.describe Product, type: :model do
  describe '#initialize' do
    context 'with free discount type' do
      let(:discount_type) { Discount::FREE }

      it 'creates a product' do
        product = described_class.new('GR1', 'Green Tea', 3.11, 'euro', discount_type)

        expect(product.code).to eq('GR1')
        expect(product.name).to eq('Green Tea')
        expect(product.price).to eq(3.11)
        expect(product.currency).to eq('euro')
        expect(product.discount_type).to eq(discount_type)
      end
    end

    context 'with absolute discount type' do
      let(:discount_type) { Discount::ABSOLUTE }

      it 'creates a product' do
        product = described_class.new('SR1', 'Strawberries', 5.0, 'euro', discount_type)

        expect(product.code).to eq('SR1')
        expect(product.name).to eq('Strawberries')
        expect(product.price).to eq(5.0)
        expect(product.currency).to eq('euro')
        expect(product.discount_type).to eq(discount_type)
      end
    end

    context 'with percent discount type' do
      let(:discount_type) { Discount::PERCENT }

      it 'creates a product' do
        product = described_class.new('CF1', 'Coffee', 11.23, 'euro', discount_type)

        expect(product.code).to eq('CF1')
        expect(product.name).to eq('Coffee')
        expect(product.price).to eq(11.23)
        expect(product.currency).to eq('euro')
        expect(product.discount_type).to eq(discount_type)
      end
    end

    context 'with invalid discount type' do
      let(:discount_type) { 'invalid' }

      it 'creates a product' do
        product = described_class.new('AA1', 'Abc', 2.5, 'euro', discount_type)

        expect(product.code).to eq('AA1')
        expect(product.name).to eq('Abc')
        expect(product.price).to eq(2.5)
        expect(product.currency).to eq('euro')
        expect(product.discount_type).to eq(discount_type)
      end
    end
  end
end
