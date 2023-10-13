# frozen_string_literal: true

class CalculatePercentDiscount
  def initialize(product, k)
    @product = product
    @k = k
  end

  def self.call(*args)
    new(*args).call
  end

  def call
    value = 0
    p = @product.price

    if @k >= @product.min_count_discount
      value = @product.percent_discount * p * @k
    end

    value
  end
end