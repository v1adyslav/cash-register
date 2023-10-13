# frozen_string_literal: true

class CalculateFreeDiscount
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

    if @k > @product.count_discount
      value = @product.free_gift * p * 1
    end

    value
  end
end