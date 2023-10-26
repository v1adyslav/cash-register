RSpec.describe Base do
  describe '#load_files' do
    it 'does not raise errors' do
      expect{ Base.load_files }.not_to raise_error
    end
  end

  describe '#add_product_to_basket' do
    let(:products_list) do
      {
        'GR1' => Product.new('GR1', 'Green Tea', 3.11, 'euro', Discount::FREE),
        'SR1' => Product.new('SR1', 'Strawberries', 5.0, 'euro', Discount::ABSOLUTE),
      }
    end

    it 'adds product to basket' do
      basket = []
      expect{ Base.add_product_to_basket('GR1', basket, products_list) }.not_to raise_error
      expect(basket).to include('GR1')
    end

    it 'does not add product to basket' do
      basket = []
      expect{ Base.add_product_to_basket('GR2', basket, products_list) }.not_to raise_error
      expect(basket).not_to include('GR2')
    end
  end
end
