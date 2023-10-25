# frozen_string_literal: true

class CalculateFreeDiscount
  def initialize(product, count, discount)
    @product = product
    @count = count
    @discount = discount
  end

  def self.call(*args)
    new(*args).call
  end

  def call
    value = 0

    value = @discount.value * @product.price * 1 if @count > @discount.count

    value
  end
end
