RSpec.describe CalculateBasketPrice, type: :service do
  describe "#call" do
    let(:product1) { Product.new('GR1', 'Green Tea', 3.11, 'euro', Discount::FREE) }
    let(:product2) { Product.new('SR1', 'Strawberries', 5.0, 'euro', Discount::ABSOLUTE) }
    let(:product3) { Product.new('CF1', 'Coffee', 11.23, 'euro', Discount::PERCENT) }
    let(:products_list) { { 'GR1' => product1, 'SR1' => product2, 'CF1' => product3 } }

    let(:discount1) { Discount.new({ 'type' => Discount::FREE, 'count' => 1, 'value' => 1 }) }
    let(:discount2) { Discount.new({ 'type' => Discount::ABSOLUTE, 'count' => 3, 'value' => 0.5 }) }
    let(:discount3) { Discount.new({ 'type' => Discount::PERCENT, 'count' => 3, 'value' => 0.3333 }) }
    let(:discounts_list) { { Discount::FREE => discount1, Discount::ABSOLUTE => discount2, Discount::PERCENT => discount3 } }

    subject { described_class.call(basket, products_list, discounts_list) }

    context 'when one special condition works' do
      context 'basket is [GR1 GR1]' do
        let(:basket) { %w[GR1 GR1] }

        it 'checks price' do
          result = subject
          expect(result.success?).to be true
          expect(result.price).to eq(3.11)
        end
      end

      context 'basket is [GR1 GR2]' do
        let(:basket) { %w[GR1 GR2] }

        it 'has incorrect product code' do
          result = subject
          expect(result.success?).to be false
        end
      end

      context 'basket is [SR1 SR1 GR1 SR1]' do
        let(:basket) { %w[SR1 SR1 GR1 SR1] }

        it 'checks price' do
          result = subject
          expect(result.success?).to be true
          expect(result.price).to eq(16.61)
        end
      end

      context 'basket is [GR1 CF1 SR1 CF1 CF1]' do
        let(:basket) { %w[GR1 CF1 SR1 CF1 CF1] }

        it 'checks price' do
          result = subject
          expect(result.success?).to be true
          expect(result.price).to eq(30.57)
        end
      end
    end

    context 'when two special conditions work' do
      context 'basket is [SR1 SR1 GR1 SR1 GR1]' do
        let(:basket) { %w[SR1 SR1 GR1 SR1 GR1] }

        it 'checks price' do
          result = subject
          expect(result.success?).to be true
          expect(result.price).to eq(16.61)
        end
      end

      context 'basket is [GR1 CF1 SR1 CF1 CF1 GR1]' do
        let(:basket) { %w[GR1 CF1 SR1 CF1 CF1 GR1] }

        it 'checks price' do
          result = subject
          expect(result.success?).to be true
          expect(result.price).to eq(30.57)
        end
      end

      context 'basket is [GR1 CF1 SR1 CF1 CF1 SR1 SR1]' do
        let(:basket) { %w[GR1 CF1 SR1 CF1 CF1 SR1 SR1] }

        it 'checks price' do
          result = subject
          expect(result.success?).to be true
          expect(result.price).to eq(39.07)
        end
      end
    end

  end
end
