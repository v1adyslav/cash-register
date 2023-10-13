# frozen_string_literal: true

require_relative 'discount/calculate_free_discount'
require_relative 'discount/calculate_absolute_discount'
require_relative 'discount/calculate_percent_discount'

class CalculateBasketPrice
  def initialize(basket, products_array, products_code_hash)
    @basket = basket
    @products_array = products_array
    @products_code_hash = products_code_hash
  end

  def self.call(*args)
    new(*args).call
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
    @products_code_hash.each { |k, v| products_count[k] = 0 }
    @basket.each { |v| products_count[v] += 1 }

    sum = 0
    @products_array.each do |product|
      k = products_count[product.code]
      p = product.price
      sum_product = k * p
      discount = 0

      discount = CalculateFreeDiscount.call(product, k) unless product.count_discount.nil?

      unless product.min_count_discount.nil?
        discount = CalculatePercentDiscount.call(product, k) unless product.percent_discount.nil?

        discount = CalculateAbsoluteDiscount.call(product, k) unless product.absolute_discount.nil?
      end

      sum += sum_product - discount
    end

    sum.round(2)
  end
end
