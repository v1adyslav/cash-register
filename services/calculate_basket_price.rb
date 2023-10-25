# frozen_string_literal: true

class CalculateBasketPrice
  def initialize(basket, products_list, discounts_list)
    @basket = basket
    @products_list = products_list
    @discount_list = discounts_list
  end

  def self.call(...)
    new(...).call
  end

  def call
    price = calculate

    Result.new(true, '', price)
  rescue StandardError => e
    Result.new(false, e.message, 0)
  end

  private

  Result = Struct.new(:success?, :message, :price)

  def calculate
    products_count = {}
    @products_list.each { |code, product| products_count[code] = 0 }
    @basket.each { |v| products_count[v] += 1 }

    sum = 0
    @products_list.each do |code, product|
      count = products_count[product.code]
      discount = @discount_list[product.discount_type]

      sum_product = count * product.price
      discount_value = 0

      discount_value = case product.discount_type
                 when Discount::FREE
                   CalculateFreeDiscount.call(product, count, discount)
                 when Discount::ABSOLUTE
                   CalculateAbsoluteDiscount.call(product, count, discount)
                 when Discount::PERCENT
                   CalculatePercentDiscount.call(product, count, discount)
                 end

      sum += sum_product - discount_value
    end

    sum.round(2)
  end
end
