RSpec.describe CalculateBasketPrice, type: :service do
  describe "#call" do
    let(:product1) do
      Product.new('GR1', 'Green Tea', 3.11, 'euro',
                  { 'type' => 'free', 'count' => 1, 'free' => 1 })
    end
    let(:product2) do
      Product.new('SR1', 'Strawberries', 5.0, 'euro',
                  { 'type' => 'absolute', 'min_count' => 3, 'absolute' => 0.5 })
    end
    let(:product3) do
      Product.new('CF1', 'Coffee', 11.23, 'euro',
                  { 'type' => 'percent', 'min_count' => 3, 'percent' => 0.3333 })
    end
    let(:products_array) { [product1, product2, product3] }

    subject { described_class.call(basket, products_array) }

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
