RSpec.describe Product, type: :model do
  describe '#initialize' do
    context 'with free discount type' do
      let(:discount_type) { 'free' }

      it 'creates a product' do
        product = described_class.new('GR1', 'Green Tea', 3.11, 'euro',
                              { 'type' => discount_type, 'count' => 1, 'free' => 1 })

        expect(product.code).to eq('GR1')
        expect(product.name).to eq('Green Tea')
        expect(product.price).to eq(3.11)
        expect(product.currency).to eq('euro')
        expect(product.discount_type).to eq(discount_type)
        expect(product.count_discount).to eq(1)
        expect(product.free_gift).to eq(1)
        expect(product.absolute_discount).to be_nil
        expect(product.percent_discount).to be_nil
      end
    end

    context 'with absolute discount type' do
      let(:discount_type) { 'absolute' }

      it 'creates a product' do
        product = described_class.new('SR1', 'Strawberries', 5.0, 'euro',
                                      { 'type' => discount_type, 'min_count' => 3, 'absolute' => 0.5 })

        expect(product.code).to eq('SR1')
        expect(product.name).to eq('Strawberries')
        expect(product.price).to eq(5.0)
        expect(product.currency).to eq('euro')
        expect(product.discount_type).to eq(discount_type)
        expect(product.min_count_discount).to eq(3)
        expect(product.absolute_discount).to eq(0.5)
        expect(product.free_gift).to be_nil
        expect(product.percent_discount).to be_nil
      end
    end

    context 'with percent discount type' do
      let(:discount_type) { 'percent' }

      it 'creates a product' do
        product = described_class.new('CF1', 'Coffee', 11.23, 'euro',
                                      { 'type' => discount_type, 'min_count' => 3, 'percent' => 0.3333 })

        expect(product.code).to eq('CF1')
        expect(product.name).to eq('Coffee')
        expect(product.price).to eq(11.23)
        expect(product.currency).to eq('euro')
        expect(product.discount_type).to eq(discount_type)
        expect(product.min_count_discount).to eq(3)
        expect(product.percent_discount).to eq(0.3333)
        expect(product.free_gift).to be_nil
        expect(product.absolute_discount).to be_nil
      end
    end

    context 'with invalid discount type' do
      let(:discount_type) { 'invalid' }

      it 'creates a product' do
        product = described_class.new('AA1', 'Abc', 2.5, 'euro',
                                      { 'type' => discount_type, 'min_count' => 3, 'percent' => 0.2 })

        expect(product.code).to eq('AA1')
        expect(product.name).to eq('Abc')
        expect(product.price).to eq(2.5)
        expect(product.currency).to eq('euro')
        expect(product.discount_type).to eq(discount_type)
        expect(product.count_discount).to be_nil
        expect(product.min_count_discount).to be_nil
        expect(product.percent_discount).to be_nil
        expect(product.free_gift).to be_nil
        expect(product.absolute_discount).to be_nil
      end
    end
  end
end
