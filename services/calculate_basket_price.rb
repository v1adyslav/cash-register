# frozen_string_literal: true

require_relative 'discount/calculate_free_discount'
require_relative 'discount/calculate_absolute_discount'
require_relative 'discount/calculate_percent_discount'

class CalculateBasketPrice
  def initialize(basket, products_array)
    @basket = basket
    @products_array = products_array
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
    @products_array.each { |product| products_count[product.code] = 0 }
    @basket.each { |v| products_count[v] += 1 }

    sum = 0
    @products_array.each do |product|
      count = products_count[product.code]
      sum_product = count * product.price
      discount = 0

      discount = case product.discount_type
                 when 'free'
                   CalculateFreeDiscount.call(product, count)
                 when 'absolute'
                   CalculateAbsoluteDiscount.call(product, count)
                 when 'percent'
                   CalculatePercentDiscount.call(product, count)
                 end

      sum += sum_product - discount
    end

    sum.round(2)
  end
end
